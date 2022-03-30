//
//  KomorebiApp.swift
//  Komorebi
//
//  Created by Domenico Cafarelli on 15/11/21.
//

import SwiftUI

@main
struct KomorebiApp: App {
    @StateObject var ViewModel = KomorebiVM.shared
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .previewInterfaceOrientation(.portrait)
                .environmentObject(ViewModel)
        }
        .onChange(of: scenePhase) { _ in
            ViewModel.DBManager.save()
            UIApplication.shared.isIdleTimerDisabled = false

        }
    }
}
