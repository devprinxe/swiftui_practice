//
//  PostDetailViewModel.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI
import Combine

@MainActor
final class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    @Published var author: User?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let apiService = APIService.shared
    
    // MARK: - Data Fetching
    
    func loadData(postId: Int) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedPost = try await apiService.fetchPost(id: postId)
            self.post = fetchedPost
            
            let fetchedAuthor = try await apiService.fetchUser(id: fetchedPost.userId)
            self.author = fetchedAuthor
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func retry(postId: Int) async {
        await loadData(postId: postId)
    }
}
