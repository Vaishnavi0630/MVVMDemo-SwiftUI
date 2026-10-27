//
//  UserView.swift
//  MVVMDemo
//
//  Created by vaishnavi sasane on 22/10/26.
//

import SwiftUI

struct UserView: View {

    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Users")
                .task {
                    await viewModel.fetchUsers()
                }
        }
    }

    // MARK: - Main Content

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading users...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if let error = viewModel.errorMessage {
            VStack(spacing: 12) {
                Text(error)
                    .foregroundStyle(.red)

                Button("Retry") {
                    Task {
                        await viewModel.fetchUsers()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        } else if viewModel.users.isEmpty {
            ContentUnavailableView(
                "No Users Found",
                systemImage: "person.slash",
                description: Text("No users are available.")
            )

        } else {
            List(viewModel.users) { user in
                userRow(user)
            }
        }
    }

    // MARK: - Reusable User Row

    @ViewBuilder
    private func userRow(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(user.name)
                .font(.headline)

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

#Preview {
    UserView()
}
