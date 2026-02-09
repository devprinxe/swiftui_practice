//
//  APIService.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import Foundation

// MARK: - API Errors
enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(statusCode: Int)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .serverError(let statusCode):
            return "Server error: \(statusCode)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

// MARK: - API Service
@MainActor
final class APIService {
    static let shared = APIService()
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: - Generic Request Method
    private func request<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.serverError(statusCode: httpResponse.statusCode)
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                print("Decoding error: \(error)")
                throw APIError.decodingError
            }
        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    // MARK: - Posts Endpoints
    
    /// Fetch all posts
    func fetchPosts() async throws -> [Post] {
        return try await request(endpoint: "/posts")
    }
    
    /// Fetch a single post by ID
    func fetchPost(id: Int) async throws -> Post {
        return try await request(endpoint: "/posts/\(id)")
    }
    
    // MARK: - Users Endpoints
    
    /// Fetch all users
    func fetchUsers() async throws -> [User] {
        return try await request(endpoint: "/users")
    }
    
    /// Fetch a single user by ID
    func fetchUser(id: Int) async throws -> User {
        return try await request(endpoint: "/users/\(id)")
    }
}
