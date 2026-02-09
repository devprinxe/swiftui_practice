//
//  UserHeaderView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct UserHeaderView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 16) {
            // Profile Image
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.appPrimary)
            
            // User Info
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .foregroundColor(.appText)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.appSecondaryText)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .cornerRadius(12)
    }
}

#Preview {
    UserHeaderView(user: User(
        id: 1,
        name: "John Doe",
        username: "johndoe",
        email: "john@example.com",
        address: Address(
            street: "123 Main St",
            suite: "Apt 1",
            city: "New York",
            zipcode: "10001",
            geo: Geo(lat: "0", lng: "0")
        ),
        phone: "123-456-7890",
        website: "johndoe.com",
        company: Company(
            name: "Tech Co",
            catchPhrase: "Innovation",
            bs: "tech"
        )
    ))
    .padding()
}
