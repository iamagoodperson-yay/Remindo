//
//  RemindoApp.swift
//  Remindo
//
//  Created by Kenzie Vimalaputta Irawan on 19/8/23.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct RemindoApp: App {
    
    init() {
        FirebaseApp.configure()
        print("Configrued firebase!")
    }
    
    var body: some Scene {
        WindowGroup {
            splashScreenView()
        }
    }
}

struct eColor {
    static let lightGreen = Color("lightGreen")
    static let darkGreen = Color("darkGreen")
    static let lightBlue = Color("lightBlue")
    static let darkBlue = Color("darkBlue")
}
