//
//  SG_Group15App.swift
//  SG-Group15
//
//  Created by Nana on 9/9/24.
//

import SwiftUI
import Firebase

@main
struct SG_Group15App: App {
    // Initialize Firebase
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
