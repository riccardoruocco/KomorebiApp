//
//  MeditationView.swift
//  komorebi
//
//  Created by Luigi Parente on 17/11/21.
//

import SwiftUI

struct MeditationView: View {
    
    @State private var selection = false
    @State private var favoritesOnly = false
    @State private var searchText = ""
    @EnvironmentObject var viewModel: KomorebiVM
        
    init() {
        // set navigation title color to white
        // UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.primary)]
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            NavigationLink(destination: MeditationPlayerView(), isActive: $selection) { EmptyView() }
            
            splashImageBackground
                .overlay(
                    VStack {
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 24) {
                                ForEach(searchResults, id: \.id) { meditation in
                                    
//                                    if self.favoritesOnly && !meditation.isFavorite {
//                                        break
//                                    }
                                    
                                    Button(action: {
                                        viewModel.cleanChosen()
                                        viewModel.chooseMeditation(identifier: meditation.id!)
                                        self.selection = true
                                    }) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            HStack {
                                                Spacer()
                                                Button(action: {
                                                    if meditation.isFavorite {
                                                        KomorebiVM.shared.removeMeditationToFavorite(identifier: meditation.id!)
                                                    } else {
                                                        KomorebiVM.shared.addMeditationToFavorite(identifier: meditation.id!)
                                                    }
                                                }) {
                                                    Image(systemName: "star.fill")
                                                        .frame(width: 36, height: 36)
                                                        .foregroundColor(meditation.isFavorite ? .yellow : .white)
                                                        .font(.system(size: 23))
                                                        .padding(2)
                                                        .background(.black.opacity(0.5))
                                                        .cornerRadius(64)
                                                        .padding(6)
                                                }
                                                    
                                            }
                                            Spacer()
                                            VStack {
                                                VStack(alignment: .leading) {
                                                    Text(meditation.name!)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                    Text("\(meditation.duration/60) minutes")
                                                        .font(.footnote)
                                                        .foregroundColor(.gray)
                                                }
                                                .padding(12)
                                                .frame(width: 160, alignment: .leading)
                                                .background(Color.black.opacity(0.7))
                                            }
                                           
                                        }
                                        .frame(width: 160, height: 160)
                                        .background(
                                            Image(meditation.imageName!)
                                                .resizable()
                                                .scaledToFit()
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
                    .navigationTitle("Choose meditation")
                    .toolbar {
                        Button(action: {
                            self.favoritesOnly.toggle()
                        }) {
                            Image(systemName: "star.fill")
                                // .frame(width: 12, height: 12)
                                .foregroundColor(self.favoritesOnly ? .yellow : .white)
                                .font(.system(size: 16))
                                // .offset(y: 3)
                        }
                    }
                    .preferredColorScheme(.dark)
                    // .background(Image("background"))
                    // .edgesIgnoringSafeArea(.vertical)
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
    
    var searchResults: [Meditation] {
        let meditations = KomorebiVM.shared.getMeditations().filter { self.favoritesOnly ? $0.isFavorite : true }
        if searchText.isEmpty {
            return meditations
        } else {
            return meditations.filter { $0.name!.contains(searchText) }
        }
    }
    
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MeditationView().environmentObject(KomorebiVM.shared)
        }
    }
}




