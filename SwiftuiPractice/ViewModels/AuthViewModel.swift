//
//  AuthViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class AuthViewModel {
    var email: String = ""
    var password: String = ""
    var fullName: String = ""
    var confirmPassword: String = ""
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    // MARK: - Validation
    
    func validateLogin() -> Bool {
        errorMessage = nil
        
        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty"
            return false
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty"
            return false
        }
        
        return true
    }
    
    func validateRegistration() -> Bool {
        errorMessage = nil
        
        guard !fullName.isEmpty else {
            errorMessage = "Full name cannot be empty"
            return false
        }
        
        guard !email.isEmpty else {
            errorMessage = "Email cannot be empty"
            return false
        }
        
        guard !password.isEmpty else {
            errorMessage = "Password cannot be empty"
            return false
        }
        
        guard !confirmPassword.isEmpty else {
            errorMessage = "Please confirm your password"
            return false
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return false
        }
        
        return true
    }
    
    // MARK: - Auth Actions
    
    func login(router: AppRouter) async {
        guard validateLogin() else { return }
        
        isLoading = true
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        isLoading = false
        
        // Mock login - accept any non-empty credentials
        router.login(userId: 1)
        
        // Clear fields
        clearFields()
    }
    
    func register(router: AppRouter) async {
        guard validateRegistration() else { return }
        
        isLoading = true
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        isLoading = false
        
        // Mock registration - accept any valid input
        router.login(userId: 1)
        
        // Clear fields
        clearFields()
    }
    
    func clearFields() {
        email = ""
        password = ""
        fullName = ""
        confirmPassword = ""
        errorMessage = nil
    }
}
