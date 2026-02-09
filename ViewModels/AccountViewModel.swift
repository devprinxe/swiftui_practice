//
//  AccountViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

@MainActor
final class AccountViewModel: ObservableObject {
    @Published var user: User?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
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
