//
//  AccountViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class AccountViewModel {
    var user: User?
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let apiService = APIService.shared
    
    // MARK: - Data Fetching
    
    func loadData(userId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedUser = try await apiService.fetchUser(id: userId)
            self.user = fetchedUser
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func retry(userId: Int) async {
        await loadData(userId: userId)
    }
}
