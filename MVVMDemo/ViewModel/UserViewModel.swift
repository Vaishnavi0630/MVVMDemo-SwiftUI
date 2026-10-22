//
//  UserViewModel.swift
//  MVVMDemo
//
//  Created by vaishnavi sasane on 22/10/26.
//

import Foundation
import Combine

@MainActor
final class UserViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let userService = UserService()

    func fetchUsers() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            try await Task.sleep(for: .seconds(3))
            users = try await userService.fetchUsers()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
