//
//  PostDetailView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct PostDetailView: View {
    let postId: Int
    
    @State private var viewModel = PostDetailViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 16) {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.appError)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        Task {
                            await viewModel.retry(postId: postId)
                        }
                    }) {
                        Text("Retry")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(Color.appPrimary)
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            } else if let post = viewModel.post {
                VStack(alignment: .leading, spacing: 24) {
                    // Post Title
                    Text(post.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.appText)
                    
                    // Author Info
                    if let author = viewModel.author {
                        HStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.appPrimary)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(author.name)
                                    .font(.headline)
                                    .foregroundColor(.appText)
                                
                                Text(author.email)
                                    .font(.caption)
                                    .foregroundColor(.appSecondaryText)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.appSecondaryBackground)
                        .cornerRadius(12)
                    }
                    
                    // Post Body
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Content")
                            .font(.headline)
                            .foregroundColor(.appText)
                        
                        Text(post.body)
                            .font(.body)
                            .foregroundColor(.appText)
                            .lineSpacing(4)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.appSecondaryBackground)
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .background(Color.appBackground)
        .navigationTitle("Post Detail")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if viewModel.post == nil {
                await viewModel.loadData(postId: postId)
            }
        }
    }
}

#Preview {
    NavigationStack {
        PostDetailView(postId: 1)
    }
}
