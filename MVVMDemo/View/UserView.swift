//
//  UserView.swift
//  MVVMDemo
//
//  Created by vaishnavi sasane on 22/10/26.
//

import SwiftUI

struct UserListView: View {

    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text(error)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)

                        Button("Retry") {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.users) { user in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(user.name)
                                .font(.headline)
                                .foregroundStyle(.blue)

                            Text(user.email)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            Text(user.phone)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UserListView()
}
