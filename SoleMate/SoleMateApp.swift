//
//  SoleMateApp.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI
import FirebaseCore

@main
struct SoleMateApp: App {

    var body: some Scene {
        WindowGroup {
            WelcomeScreen().onAppear(){
                FirebaseApp.configure()
            }
        }
    }
}

