//
//  User.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import Foundation

// MARK: - User Model
struct User: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

// MARK: - Address Model
struct Address: Codable, Hashable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// MARK: - Geo Model
struct Geo: Codable, Hashable {
    let lat: String
    let lng: String
}

// MARK: - Company Model
struct Company: Codable, Hashable {
    let name: String
    let catchPhrase: String
    let bs: String
}
