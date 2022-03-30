//
//  ContentView.swift
//  Komorebi
//
//  Created by Luigi Parente on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection: String? = nil
    @EnvironmentObject var viewModel: KomorebiVM
    
    var body: some View {
        NavigationView {
            splashImageBackground
                .overlay(
                    ZStack {
                        NavigationLink(destination: MeditationView(), tag: "Meditation", selection: $selection) { EmptyView() }
                        NavigationLink(destination: RelaxingSoundsPlayerView(), tag: "Relaxing Sounds", selection: $selection) { EmptyView() }
                        
                        VStack {
                            Image("AppIconRounded")
                                .resizable()
                                // .scaledToFit()
                                .frame(width: 100, height: 100)
                                // .padding(32)
                                // .offset(y: -32)
                                .padding(24)
                                .background(.black.opacity(0.4))
                                .cornerRadius(40)
                            
                            Text(" ") // Komorebi
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .offset(y: -32)
                            
                            Spacer()
                            
                            HStack {
                                Text("Select your activity")
                                    .foregroundColor(.white)
                                    .font(.title2.bold())
                                // Spacer()
                            }
                            .padding(.vertical, 32)
                            
                            VStack {
                                
                                Group {
                                    Button(action: { self.selection = "Meditation" }) {
                                        ZStack{
                                            VStack(spacing: 10){
                                                Text("Meditation")
                                                    .font(.title2).bold()
                                                
                                                Text("Begin your daily\nmeditation journey!")
                                                    .font(.system(size: 12))
                                            }.multilineTextAlignment(.leading)
                                                .frame(width: 286, height: 100)
                                                .offset(x: -70, y: 0)
                                            
                                            Image(uiImage: UIImage(named: "Meditation1.png")!)
                                                .opacity(0.3)
                                                .offset(x: 85, y: 0)
                                        }
                                    }
                                    
                                    Button(action: { self.selection = "Relaxing Sounds" }) {
                                        ZStack{
                                            Image(uiImage: UIImage(named: "Sounds.png")!)
                                                .opacity(0.3)
                                                .offset(x: 55, y: 0)
                                            VStack(spacing: 10){
                                                
                                                Text("Relaxing Sounds")
                                                    .font(.title2).bold()
                                                
                                                Text("Compose your own\nrelaxing sounds!")
                                                    .font(.system(size: 12))
                                                    .offset(x: -20, y: 0)
                                                
                                            }.multilineTextAlignment(.leading)
                                                .frame(width: 286, height: 100)
                                                .offset(x: -40, y: 0)
                                        }
                                    }
                                }
                                .background(Color(red: 23/255, green: 15/255, blue: 116/255, opacity: 0.5))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .padding(.vertical, 8)
                            }
                            .padding(32.0)
                            .background(Color(red: 114/255, green: 126/255, blue: 237/255, opacity: 0.5))
                            .cornerRadius(32)
                        }
                    }
                        .padding(32)
                        .padding(.bottom, 100)
                )
        }.accentColor(.white)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(KomorebiVM.shared)
    }
}



