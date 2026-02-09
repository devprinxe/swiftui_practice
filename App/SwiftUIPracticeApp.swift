//
//  SwiftUIPracticeApp.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

@main
struct SwiftUIPracticeApp: App {
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
