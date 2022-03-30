//
//  RelaxingSoundsPlayerView.swift
//  Komorebi
//
//  Created by Luigi Parente on 23/11/21.
//

import SwiftUI
import MediaPlayer

struct RelaxingSoundsPlayerView: View {
    
    @State var selectingSound = false
    var sounds:[Music] {
        KomorebiVM.shared.getChosenMusics()
    }
    @State var soundValues:[Double] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    @State var nSlider = 1
    @State var volume:Double = 0.0
    @State var playing: Bool = false
    @EnvironmentObject var viewModel: KomorebiVM
    
    
    var body: some View {
        
//        VolumeSliders()
//            .frame(height: 40)
//            .padding(.horizontal)
        
        splashImageBackground
            .overlay(
                VStack {
                    
                    ScrollView {
                        VStack {
                            
                            ForEach(sounds) { sound in
                                HStack {
                                    Image(sound.imageName!)
                                        .resizable()
                                        .frame(width: 92, height: 92, alignment: .center)
                                        .cornerRadius(16)
                                    // Spacer()
                                    VStack(alignment: .leading) {
                                        Text(sound.title!)
                                            .font(.title2.bold())
                                            .foregroundColor(.white)
                                        HStack {
                                            Slider(
                                                value:$soundValues[sounds.index(of: sound)!],
                                                in: 0...50,
                                                onEditingChanged: { editing in
                                                    sound.volume = soundValues[sounds.index(of: sound)!]
                                                    KomorebiVM.shared.chooseVolumes(identifier: sound.id!, newVolume: sound.volume)
                                                    
                                                    self.playing = false
                                                    KomorebiVM.shared.stopSoundSession()
                                                }
                                            )
                                                .onAppear(){
                                                    soundValues[sounds.index(of: sound)!] = sound.volume
                                                }
                                                .accentColor(.white)
                                            Spacer()
                                            Button(action: {
                                                viewModel.removeFromChosen(identifier: sound.id!)
                                                
                                                self.playing = false
                                                KomorebiVM.shared.stopSoundSession()
                                            }) {
                                                Image(systemName: "xmark")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 24, weight: .bold))
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }
                                .padding(24)
                            }
                            HStack {
                                Button(action: {
                                    self.selectingSound.toggle()
                                    
                                }) {
                                    Image(systemName: "plus.app.fill")
                                        .foregroundColor(.white.opacity(0.7))
                                        .font(.system(size: 45))
                                }
                                .sheet(isPresented: self.$selectingSound) {
                                    NavigationView {
                                        RelaxingSoundsSheetView()
                                    }
                                }
                            }
                            .padding(24)
                        }
                    }
                    
                    HStack {
                        Button(action: {
                            
                            if self.playing {
                                KomorebiVM.shared.stopSoundSession()
                                UIApplication.shared.isIdleTimerDisabled = false
                            }
                            else{
                                KomorebiVM.shared.startSoundSession(tracce: sounds)
                                UIApplication.shared.isIdleTimerDisabled = true


                            }
                            self.playing.toggle()
                            
                        }) {
                            Image(systemName: self.playing ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 50))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.top, 32)
                    .background(Color.black.opacity(0.7))
                }
                    .navigationTitle("Relaxing sounds")
                    .preferredColorScheme(.dark)
                    .onDisappear(perform: {
//                        KomorebiVM.shared.cleanVolumes()
                        KomorebiVM.shared.stopSoundSession()
                        UIApplication.shared.isIdleTimerDisabled = false

                    })
            )
        
    }
    
    private var splashImageBackground: some View {
        GeometryReader { geometry in
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width)
        }
    }
}

struct RelaxingSoundsPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RelaxingSoundsPlayerView().environmentObject(KomorebiVM.shared)
        }
    }
}


struct VolumeSliders: UIViewRepresentable{
    func makeUIView(context: Context) -> MPVolumeView {
        MPVolumeView(frame: .zero)
    }
    func updateUIView(_ uiView: MPVolumeView, context: Context) {}
}

