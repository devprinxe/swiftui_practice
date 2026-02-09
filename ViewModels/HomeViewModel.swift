//
//  HomeViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var users: [User] = []
    @Published var currentUser: User?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    // MARK: - Data Fetching
    
    func loadData(userId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let postsTask = apiService.fetchPosts()
            async let usersTask = apiService.fetchUsers()
            async let currentUserTask = apiService.fetchUser(id: userId)
            
            let (fetchedPosts, fetchedUsers, fetchedCurrentUser) = try await (postsTask, usersTask, currentUserTask)
            
            self.posts = fetchedPosts
            self.users = fetchedUsers
            self.currentUser = fetchedCurrentUser
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func retry(userId: Int) async {
        await loadData(userId: userId)
    }
    
    // MARK: - Helper Methods
    
    func getAuthor(for post: Post) -> User? {
        return users.first { $0.id == post.userId }
    }
}
