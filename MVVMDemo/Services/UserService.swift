//
//  UserService.swift
//  MVVMDemo
//
//  Created by vaishnavi sasane on 22/10/26.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

struct UserService {
    func fetchUsers() async throws -> [User] {
        let url = URL(
            string: "https://jsonplaceholder.typicode.com/users"
        )!

        let (data, response) = try await URLSession.shared.data(
            from: url
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidStatusCode(httpResponse.statusCode)
        }

        return try JSONDecoder().decode([User].self, from: data)
    }
}
