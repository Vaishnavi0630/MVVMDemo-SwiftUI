//
//  User.swift
//  MVVMDemo
//
//  Created by vaishnavi sasane on 22/10/26.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}
