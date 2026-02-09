//
//  Post.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import Foundation

// MARK: - Post Model
struct Post: Codable, Identifiable, Hashable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
