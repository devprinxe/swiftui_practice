//
//  PostListView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct PostListView: View {
    @EnvironmentObject var router: AppRouter
    @State private var viewModel = PostListViewModel()
    
    var body: some View {
        NavigationStack(path: $router.listPath) {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.appError)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            Task {
                                await viewModel.retry()
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
                    .padding()
                } else {
                    List(viewModel.posts) { post in
                        Button(action: {
                            router.push(ListRoute.postDetail(postId: post.id))
                        }) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(post.title)
                                    .font(.headline)
                                    .foregroundColor(.appText)
                                    .lineLimit(2)
                                
                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.appSecondaryText)
                                    .lineLimit(3)
                                
                                if let author = viewModel.getAuthor(for: post) {
                                    HStack {
                                        Image(systemName: "person.circle")
                                            .foregroundColor(.appPrimary)
                                        
                                        Text(author.name)
                                            .font(.caption)
                                            .foregroundColor(.appTertiaryText)
                                    }
                                    .padding(.top, 4)
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("All Posts")
            .navigationDestination(for: ListRoute.self) { route in
                switch route {
                case .postDetail(let postId):
                    PostDetailView(postId: postId)
                }
            }
            .task {
                if viewModel.posts.isEmpty {
                    await viewModel.loadData()
                }
            }
        }
    }
}

#Preview {
    PostListView()
        .environmentObject(AppRouter())
}
