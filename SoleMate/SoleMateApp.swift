//
//  SoleMateApp.swift
//  SoleMate
//
//  Created by Yoobin Lee on 5/19/25.
//

import SwiftUI
import FirebaseCore




//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}


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
