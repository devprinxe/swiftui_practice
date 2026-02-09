//
//  Routes.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import Foundation

// MARK: - Tab Enum
enum Tab: Hashable {
    case home
    case list
    case account
}

// MARK: - Auth Routes
enum AuthRoute: Hashable {
    case login
    case register
}

// MARK: - Home Routes
enum HomeRoute: Hashable {
    case postDetail(postId: Int)
}

// MARK: - List Routes
enum ListRoute: Hashable {
    case postDetail(postId: Int)
}

// MARK: - Account Routes
enum AccountRoute: Hashable {
    case editProfile
}
