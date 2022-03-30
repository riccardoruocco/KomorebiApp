//
//  RelaxingSoundsSheetView.swift
//  Komorebi
//
//  Created by Luigi Parente on 24/11/21.
//

import SwiftUI

struct RelaxingSoundsSheetView: View {
    @EnvironmentObject var viewModel: KomorebiVM

    // @State private var selection = false
    @Environment(\.presentationMode) var presentationMode
    @State private var favoritesOnly = false
    @State private var searchText = ""

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            // NavigationLink(destination: MeditationPlayerView(), isActive: $selection) { EmptyView() }
            
            splashImageBackground
                .overlay(
                    VStack {
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 24) {
                                ForEach(searchResults, id: \.id) { sound in
                                    
                                    Button(action: {
                                        // viewModel.cleanChosen()
                                        // viewModel.chooseMeditation(identifier: meditation.id!)
                                        // self.selection = true
                                        viewModel.chooseMusic(identifier: sound.id!)
                                        presentationMode.wrappedValue.dismiss()
                                    }) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Spacer()
                                            VStack {
                                                VStack(alignment: .leading) {
                                                    Text(sound.title!)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                }
                                                .padding(12)
                                                .frame(width: 160, alignment: .leading)
                                                .background(Color.black.opacity(0.7))
                                            }
                                           
                                        }
                                        .frame(width: 160, height: 160)
                                        .background(
                                            Image(sound.imageName!)
                                                .resizable()
                                                .scaledToFill()
                                        )
                                        .cornerRadius(16)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .searchable(text: $searchText)
                        // .padding(.vertical, 32)
                     
                        
                    }
                    .navigationTitle("Choose sound")
//                    .toolbar {
//                        Button(action: {
//                            self.favoritesOnly.toggle()
//                        }) {
//                            Image(systemName: "star.fill")
//                                // .frame(width: 12, height: 12)
//                                .foregroundColor(self.favoritesOnly ? .yellow : .white)
//                                .font(.system(size: 16))
//                                // .offset(y: 3)
//                        }
//                    }
                    .preferredColorScheme(.dark)
                )
        }
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
    
    var searchResults: [Music] {
        let sounds = KomorebiVM.shared.getMusics()
        if searchText.isEmpty {
            return sounds
        } else {
            return sounds.filter { $0.title!.contains(searchText) }
        }
    }
}

struct RelaxingSoundsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RelaxingSoundsSheetView().environmentObject(KomorebiVM.shared)
        }
    }
}


