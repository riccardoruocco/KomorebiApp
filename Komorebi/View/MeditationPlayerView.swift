//
//  MeditationPlayerView.swift
//  Komorebi
//
//  Created by Luigi Parente on 22/11/21.
//

import SwiftUI

struct MeditationPlayerView: View {
    
    @EnvironmentObject var viewModel: KomorebiVM
    @State var timeRemaining: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        splashImageBackground
            .overlay(
                VStack {
                    Spacer()
                    
                    // Text(viewModel.getChoosen()!.name ?? "Hello World")
                    
                    HStack {
                        GifViewer("meditationloader")
                            .offset(y: 150)
                            .opacity(self.timeRemaining > 0 ? 1 : 0)
                            .animation(.easeInOut(duration: 2), value: self.timeRemaining > 0)
                    }
                    .padding(.horizontal, 80)
                    
                    Spacer()
                    
                    HStack {
                        if self.timeRemaining == 0 {
                            
                            Button(action: {
                                let meditation = viewModel.getChoosen()
                                if let meditation = meditation {
                                    viewModel.startMeditation(meditation.name!+".mp3")
                                    self.timeRemaining = Int(meditation.duration)
                                    UIApplication.shared.isIdleTimerDisabled = true
                                }
                            }) {
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 50))
                            }
                            
                        } else {
                            Text("\((self.timeRemaining % 3600) / 60):\((self.timeRemaining % 3600) % 60)")
                                .foregroundColor(.white)
                                .font(.largeTitle.bold())
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .padding(.top, 32)
                    .background(Color.black.opacity(0.7))
                }
                .navigationTitle("Meditation")
                .onDisappear(perform: {
                    viewModel.stopMeditation()
                    UIApplication.shared.isIdleTimerDisabled = false

                })
                .onReceive(timer) { time in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                }
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

struct MeditationPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeditationPlayerView(timeRemaining: 0).environmentObject(KomorebiVM.shared)
        }
        .preferredColorScheme(.dark)
    }
}
