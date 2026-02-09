//
//  AccountView.swift
//  SwiftUIPractice
//
//  Created on 2026-02-09.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var viewModel = AccountViewModel()
    
    var body: some View {
        NavigationStack(path: $router.accountPath) {
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
                } else if let user = viewModel.user {
                    VStack(spacing: 24) {
                        // Profile Header
                        VStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.appPrimary)
                            
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.appText)
                            
                            Text("@\(user.username)")
                                .font(.subheadline)
                                .foregroundColor(.appSecondaryText)
                        }
                        .padding(.top)
                        
                        // User Details
                        VStack(spacing: 16) {
                            // Contact Information
                            GroupBox(label: Label("Contact Information", systemImage: "envelope.fill")) {
                                VStack(alignment: .leading, spacing: 12) {
                                    InfoRow(label: "Email", value: user.email)
                                    Divider()
                                    InfoRow(label: "Phone", value: user.phone)
                                    Divider()
                                    InfoRow(label: "Website", value: user.website)
                                }
                                .padding(.vertical, 8)
                            }
                            
                            // Company Information
                            GroupBox(label: Label("Company", systemImage: "building.2.fill")) {
                                VStack(alignment: .leading, spacing: 12) {
                                    InfoRow(label: "Name", value: user.company.name)
                                    Divider()
                                    InfoRow(label: "Catchphrase", value: user.company.catchPhrase)
                                }
                                .padding(.vertical, 8)
                            }
                            
                            // Address Information
                            GroupBox(label: Label("Address", systemImage: "map.fill")) {
                                VStack(alignment: .leading, spacing: 12) {
                                    InfoRow(label: "Street", value: user.address.street)
                                    Divider()
                                    InfoRow(label: "Suite", value: user.address.suite)
                                    Divider()
                                    InfoRow(label: "City", value: user.address.city)
                                    Divider()
                                    InfoRow(label: "Zipcode", value: user.address.zipcode)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Logout Button
                        Button(action: {
                            router.logout()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.appError)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                    }
                }
            }
            .background(Color.appBackground)
            .navigationTitle("Account")
            .navigationDestination(for: AccountRoute.self) { route in
                switch route {
                case .editProfile:
                    Text("Edit Profile")
                }
            }
            .task {
                if viewModel.user == nil {
                    await viewModel.loadData(userId: router.currentUserId)
                }
            }
        }
    }
}

// MARK: - Info Row
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.appSecondaryText)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.appText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AccountView()
        .environmentObject(AppRouter())
}
