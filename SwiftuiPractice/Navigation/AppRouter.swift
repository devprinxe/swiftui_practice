//
//  AppRouter.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
final class AppRouter: ObservableObject {
    // MARK: - Auth State
    @AppStorage("is_logged_in") var isAuthenticated: Bool = false
    @Published var showSplash: Bool = true
    
    // MARK: - Tab State
    @Published var activeTab: Tab = .home
    
    // MARK: - Per-Tab NavigationPaths
    @Published var homePath = NavigationPath()
    @Published var listPath = NavigationPath()
    @Published var accountPath = NavigationPath()
    
    // MARK: - Auth Flow NavigationPath
    @Published var authPath = NavigationPath()
    
    // MARK: - Sheet State
    @Published var presentedSheet: AnySheet?
    
    // MARK: - User State
    @Published var currentUserId: Int = 1 // Mock user ID
    
    // MARK: - Navigation Methods
    
    /// Push a route to the appropriate navigation path
    func push<T: Hashable>(_ route: T, for tab: Tab? = nil) {
        let targetTab = tab ?? activeTab
        switch targetTab {
        case .home:
            homePath.append(route)
        case .list:
            listPath.append(route)
        case .account:
            accountPath.append(route)
        }
    }
    
    /// Push an auth route
    func pushAuth(_ route: AuthRoute) {
        authPath.append(route)
    }
    
    /// Pop the last route from the current tab's path
    func pop(for tab: Tab? = nil) {
        let targetTab = tab ?? activeTab
        switch targetTab {
        case .home:
            if !homePath.isEmpty {
                homePath.removeLast()
            }
        case .list:
            if !listPath.isEmpty {
                listPath.removeLast()
            }
        case .account:
            if !accountPath.isEmpty {
                accountPath.removeLast()
            }
        }
    }
    
    /// Pop all routes from the current tab's path
    func popToRoot(for tab: Tab? = nil) {
        let targetTab = tab ?? activeTab
        switch targetTab {
        case .home:
            homePath = NavigationPath()
        case .list:
            listPath = NavigationPath()
        case .account:
            accountPath = NavigationPath()
        }
    }
    
    /// Switch to a specific tab
    func switchTab(to tab: Tab) {
        activeTab = tab
    }
    
    /// Present a sheet
    func presentSheet(_ sheet: AnySheet) {
        presentedSheet = sheet
    }
    
    /// Dismiss the presented sheet
    func dismissSheet() {
        presentedSheet = nil
    }
    
    /// Handle deep links (placeholder for future implementation)
    func handleDeepLink(_ url: URL) {
        // Parse URL and navigate accordingly
        // Example: swiftuipractice://post/123
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return
        }
        
        let path = components.path
        if path.hasPrefix("/post/") {
            let postIdString = path.replacingOccurrences(of: "/post/", with: "")
            if let postId = Int(postIdString) {
                switchTab(to: .home)
                push(HomeRoute.postDetail(postId: postId))
            }
        }
    }
    
    /// Login user
    func login(userId: Int = 1) {
        currentUserId = userId
        isAuthenticated = true
        authPath = NavigationPath() // Clear auth navigation
    }
    
    /// Logout user
    func logout() {
        isAuthenticated = false
        currentUserId = 1
        
        // Clear all navigation paths
        homePath = NavigationPath()
        listPath = NavigationPath()
        accountPath = NavigationPath()
        authPath = NavigationPath()
        
        // Reset to home tab
        activeTab = .home
    }
    
    /// Dismiss splash screen
    func dismissSplash() {
        showSplash = false
    }
}
