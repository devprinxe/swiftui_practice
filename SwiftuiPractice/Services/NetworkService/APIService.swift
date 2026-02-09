//
//  APIClient.swift
//  SwiftUIPractice
//
//  Network/APIClient.swift
//

import Foundation

// MARK: - API Client (Base HTTP Client)
final class APIService {
    static let shared = APIService()
    
    private let session: URLSession
    private let baseURL: String
    
    private init(baseURL: String = ApiConstants.baseURL) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
        self.baseURL = baseURL
    }
    
    // MARK: - Generic Request with Response
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) async throws -> T {
        let request = try buildRequest(
            endpoint: endpoint,
            method: method,
            body: body,
            headers: headers,
            queryParameters: queryParameters
        )
        
        let (data, response) = try await session.data(for: request)
        
        try validateResponse(response)
        
        return try decode(data)
    }
    
    // MARK: - Request without Response (for DELETE, etc.)
    func requestWithoutResponse(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable? = nil,
        headers: [String: String]? = nil,
        queryParameters: [String: String]? = nil
    ) async throws {
        let request = try buildRequest(
            endpoint: endpoint,
            method: method,
            body: body,
            headers: headers,
            queryParameters: queryParameters
        )
        
        let (_, response) = try await session.data(for: request)
        
        try validateResponse(response)
    }
    
    // MARK: - Private Helpers
    
    private func buildRequest(
        endpoint: String,
        method: HTTPMethod,
        body: Encodable?,
        headers: [String: String]?,
        queryParameters: [String: String]?
    ) throws -> URLRequest {
        var urlString = baseURL + endpoint
        
        // Add query parameters
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            var components = URLComponents(string: urlString)
            components?.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            urlString = components?.url?.absoluteString ?? urlString
        }
        
        guard let url = URL(string: urlString) else {
            throw ApiExceptions.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // Default headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // Custom headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Add body
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw ApiExceptions.encodingError
            }
        }
        
        return request
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiExceptions.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
        case 401:
            throw ApiExceptions.unauthorized
        case 403:
            throw ApiExceptions.forbidden
        case 404:
            throw ApiExceptions.notFound
        case 400...499:
            throw ApiExceptions.clientError(statusCode: httpResponse.statusCode)
        case 500...599:
            throw ApiExceptions.serverError(statusCode: httpResponse.statusCode)
        default:
            throw ApiExceptions.serverError(statusCode: httpResponse.statusCode)
        }
    }
    
    private func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Decoding error: \(error)")
            if let json = String(data: data, encoding: .utf8) {
                print("❌ Response JSON: \(json)")
            }
            throw ApiExceptions.decodingError
        }
    }
    
    // MARK: - Posts Endpoints
    
    /// Fetch all posts
    func fetchPosts() async throws -> [Post] {
        return try await request(endpoint: ApiConstants.postsEndpoint)
    }
    
    /// Fetch a single post by ID
    func fetchPost(id: Int) async throws -> Post {
        return try await request(endpoint: "\(ApiConstants.postsEndpoint)/\(id)")
    }
    
    // MARK: - Users Endpoints
    
    /// Fetch all users
    func fetchUsers() async throws -> [User] {
        return try await request(endpoint: ApiConstants.usersEndpoint)
    }
    
    /// Fetch a single user by ID
    func fetchUser(id: Int) async throws -> User {
        return try await request(endpoint: "\(ApiConstants.usersEndpoint)/\(id)")
    }
}
