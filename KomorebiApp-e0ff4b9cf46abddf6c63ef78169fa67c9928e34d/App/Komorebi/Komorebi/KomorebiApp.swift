//
//  KomorebiApp.swift
//  Komorebi
//
//  Created by Domenico Cafarelli on 15/11/21.
//

import SwiftUI

@main
struct KomorebiApp: App {
    @StateObject var ViewModel = KomorebiVM()
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ViewModel)
        }
        .onChange(of: scenePhase) { _ in
            ViewModel.DBManager.save()
        }
    }
}
