//
//  ContentView.swift
//  Komorebi
//
//  Created by Domenico Cafarelli on 15/11/21.
//

import SwiftUI
import CoreData



struct ContentView: View {
    @EnvironmentObject var viewModel:KomorebiVM

    var body: some View {
        VStack {
            Text("Text")

            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static let ViewModel = KomorebiVM()
    
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel)
    }
}
