//
//  Color+Extensions.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

extension Color {
    // MARK: - App Theme Colors
    
    static let appPrimary = Color(red: 0.2, green: 0.4, blue: 0.8)
    static let appSecondary = Color(red: 0.3, green: 0.5, blue: 0.9)
    static let appAccent = Color(red: 1.0, green: 0.6, blue: 0.2)
    
    static let appBackground = Color(UIColor.systemBackground)
    static let appSecondaryBackground = Color(UIColor.secondarySystemBackground)
    static let appTertiaryBackground = Color(UIColor.tertiarySystemBackground)
    
    static let appText = Color(UIColor.label)
    static let appSecondaryText = Color(UIColor.secondaryLabel)
    static let appTertiaryText = Color(UIColor.tertiaryLabel)
    
    static let appSuccess = Color.green
    static let appError = Color.red
    static let appWarning = Color.orange
}
