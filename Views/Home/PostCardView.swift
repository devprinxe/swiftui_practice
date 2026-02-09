//
//  PostCardView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct PostCardView: View {
    let post: Post
    let author: User?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title
            Text(post.title)
                .font(.headline)
                .foregroundColor(.appText)
                .lineLimit(2)
            
            // Body snippet
            Text(post.body)
                .font(.subheadline)
                .foregroundColor(.appSecondaryText)
                .lineLimit(3)
            
            // Author info
            if let author = author {
                HStack {
                    Image(systemName: "person.circle")
                        .foregroundColor(.appPrimary)
                    
                    Text(author.name)
                        .font(.caption)
                        .foregroundColor(.appTertiaryText)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .cornerRadius(12)
    }
}

#Preview {
    PostCardView(
        post: Post(
            userId: 1,
            id: 1,
            title: "Sample Post Title",
            body: "This is a sample post body that demonstrates how the post card looks with some text content."
        ),
        author: User(
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
        )
    )
    .padding()
}
