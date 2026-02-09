//
//  LoginView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: AppRouter
    @State private var viewModel = AuthViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Text("Login to continue")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                }
                .padding(.top, 40)
                
                // Form Fields
                VStack(spacing: 16) {
                    // Email Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.appText)
                        
                        TextField("Enter your email", text: $viewModel.email)
                            .textFieldStyle(.plain)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(10)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.appText)
                        
                        SecureField("Enter your password", text: $viewModel.password)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(10)
                    }
                }
                .padding(.top, 20)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.appError)
                        .padding(.horizontal)
                }
                
                // Login Button
                Button(action: {
                    Task {
                        await viewModel.login(router: router)
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                }
                .background(Color.appPrimary)
                .cornerRadius(12)
                .disabled(viewModel.isLoading)
                .padding(.top, 8)
                
                // Switch to Register
                HStack {
                    Text("Don't have an account?")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                    
                    Button(action: {
                        router.authPath.removeLast()
                        router.pushAuth(.register)
                    }) {
                        Text("Register")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.appPrimary)
                    }
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .background(Color.appBackground)
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AppRouter())
    }
}
