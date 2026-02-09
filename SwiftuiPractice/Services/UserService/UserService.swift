//
//  UserService.swift
//  SwiftuiPractice
//
//  Created by TechnoNext on 9/2/26.
//

import Foundation

protocol UserServiceProtocol {
    func fetchUser() async throws -> [User]
    func getUser(id: Int) async throws -> User
}


class UserService: UserServiceProtocol {
    nonisolated static let shared = UserService()
    
    private let endpoint = ApiConstants.usersEndpoint
    private let client : APIService
    
    init(client: APIService = .shared) {
        self.client = client
    }
    
    func fetchUser() async throws -> [User] {
        return try await client.request(
            endpoint: endpoint,
            method: .get
        )
    }
    
    func getUser(id: Int) async throws -> User {
        return try await client.request(
        endpoint: "\(endpoint)/\(id)",
        method: .get
    )
    }
}
