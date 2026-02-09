//
//  WelcomeView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        NavigationStack(path: $router.authPath) {
            VStack(spacing: 40) {
                Spacer()
                
                // App Branding
                VStack(spacing: 16) {
                    Image(systemName: "swift")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.appPrimary)
                    
                    Text("SwiftUI Practice")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Text("Master SwiftUI Navigation")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                }
                
                Spacer()
                
                // Action Buttons
                VStack(spacing: 16) {
                    Button(action: {
                        router.pushAuth(.login)
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appPrimary)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        router.pushAuth(.register)
                    }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.appPrimary)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appPrimary.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .login:
                    LoginView()
                case .register:
                    RegisterView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppRouter())
}
