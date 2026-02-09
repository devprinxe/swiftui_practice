//
//  AnySheet.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import Foundation

// MARK: - Sheet Definitions
enum AnySheet: Identifiable {
    case editProfile
    
    var id: String {
        switch self {
        case .editProfile:
            return "editProfile"
        }
    }
}
