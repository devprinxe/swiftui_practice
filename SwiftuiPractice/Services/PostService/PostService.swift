//
//  PostService.swift
//  SwiftuiPractice
//
//  Created by TechnoNext on 9/2/26.
//

import Foundation

protocol PostServiceProtocol {
    func fetchPosts() async throws -> [Post]
    func fetchPost(id: Int) async throws -> Post
}

class PostService: PostServiceProtocol {
    nonisolated static let shared = PostService()
    
    private let client: APIService
    private let endpoint = ApiConstants.postsEndpoint
    
    private init(client: APIService = .shared) {
        self.client = client
    }
    
    // MARK: - GET Requests
    
    /// Fetch all posts
    func fetchPosts() async throws -> [Post] {
        return try await client.request(
            endpoint: endpoint,
            method: .get
        )
    }
    
    /// Fetch a single post by ID
    func fetchPost(id: Int) async throws -> Post {
        return try await client.request(
            endpoint: "\(endpoint)/\(id)",
            method: .get
        )
    }
}
