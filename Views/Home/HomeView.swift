//
//  HomeView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $router.homePath) {
            ScrollView {
                VStack(spacing: 20) {
                    // User Header
                    if let user = viewModel.currentUser {
                        UserHeaderView(user: user)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    
                    // Posts Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recent Posts")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.appText)
                            .padding(.horizontal)
                        
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
                                        await viewModel.retry(userId: router.currentUserId)
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
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.posts) { post in
                                    Button(action: {
                                        router.push(HomeRoute.postDetail(postId: post.id))
                                    }) {
                                        PostCardView(
                                            post: post,
                                            author: viewModel.getAuthor(for: post)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color.appBackground)
            .navigationTitle("Home")
            .navigationDestination(for: HomeRoute.self) { route in
                switch route {
                case .postDetail(let postId):
                    PostDetailView(postId: postId)
                }
            }
            .task {
                if viewModel.posts.isEmpty {
                    await viewModel.loadData(userId: router.currentUserId)
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AppRouter())
}
