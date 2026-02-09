//
//  PostListViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class PostListViewModel {
    var posts: [Post] = []
    var users: [User] = []
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let apiService = APIService.shared
    
    // MARK: - Data Fetching
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let postsTask = apiService.fetchPosts()
            async let usersTask = apiService.fetchUsers()
            
            let (fetchedPosts, fetchedUsers) = try await (postsTask, usersTask)
            
            self.posts = fetchedPosts
            self.users = fetchedUsers
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func retry() async {
        await loadData()
    }
    
    // MARK: - Helper Methods
    
    func getAuthor(for post: Post) -> User? {
        return users.first { $0.id == post.userId }
    }
}
