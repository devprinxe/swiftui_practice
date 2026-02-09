//
//  SwiftuiPracticeApp.swift
//  SwiftuiPractice
//
//  Created by TechnoNext on 9/2/26.
//

import SwiftUI

@main
struct SwiftuiPracticeApp: App {
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if router.showSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    if router.isAuthenticated {
                        MainTabView()
                            .transition(.opacity)
                    } else {
                        WelcomeView()
                            .transition(.opacity)
                    }
                }
            }
            .environmentObject(router)
            .animation(.easeInOut, value: router.showSplash)
            .animation(.easeInOut, value: router.isAuthenticated)
        }
    }
}
