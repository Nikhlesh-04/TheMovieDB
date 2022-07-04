//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 02/07/22.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
//    let persistenceController = PersistenceController.shared

    let state = AppState()
    let dispatchView = DispatchView()
    
    var body: some Scene {
        WindowGroup {
            dispatchView.environmentObject(state)
        }
    }
}
