//
//  RegisterView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    Text("Sign up to get started")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                }
                .padding(.top, 40)
                
                // Form Fields
                VStack(spacing: 16) {
                    // Full Name Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Full Name")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.appText)
                        
                        TextField("Enter your full name", text: $viewModel.fullName)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color.appSecondaryBackground)
                            .cornerRadius(10)
                    }
                    
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
                    
                    // Confirm Password Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Confirm Password")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.appText)
                        
                        SecureField("Confirm your password", text: $viewModel.confirmPassword)
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
                
                // Register Button
                Button(action: {
                    Task {
                        await viewModel.register(router: router)
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                    } else {
                        Text("Register")
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
                
                // Switch to Login
                HStack {
                    Text("Already have an account?")
                        .font(.subheadline)
                        .foregroundColor(.appSecondaryText)
                    
                    Button(action: {
                        router.authPath.removeLast()
                        router.pushAuth(.login)
                    }) {
                        Text("Login")
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
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RegisterView()
            .environmentObject(AppRouter())
    }
}
