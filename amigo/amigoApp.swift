//
//  amigoApp.swift
//  amigo
//
//  Created by Amogh on 06/03/24.
//

import SwiftUI
import FirebaseCore

@main
struct amigoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("usersignIn") var userIsSignIn: Bool = false
    @AppStorage("usersignUp") var userIsSignUp: Bool = false
    @State var showLaunchScreen: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if userIsSignIn {
                    ContentView()
                } else {
                    SignUpView()
                }
            }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Working")
    return true
  }
}
