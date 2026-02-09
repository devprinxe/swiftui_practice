//
//  HomeViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
@Observable
final class HomeViewModel {
    var posts: [Post] = []
    var users: [User] = []
    var currentUser: User?
    
    var isLoading: Bool = false
    var errorMessage: String?
    
//    private let postService = PostService.shared
//    private let userService = UserService.shared
    
    private let postService: PostServiceProtocol
    private let userService: UserServiceProtocol
    
    init(postService: PostServiceProtocol = PostService.shared, userService: UserServiceProtocol = UserService.shared) {
        self.postService = postService
        self.userService = userService
    }
    
    // MARK: - Data Fetching
    
    func loadData(userId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let postsTask = postService.fetchPosts()
            async let usersTask = userService.fetchUser()
            async let currentUserTask = userService.getUser(id: userId)
            
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
