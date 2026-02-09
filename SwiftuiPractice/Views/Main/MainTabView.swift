//
//  MainTabView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        TabView(selection: $router.activeTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            PostListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
                .tag(Tab.account)
        }
        .accentColor(.appPrimary)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppRouter())
}
