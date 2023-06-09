//
//  UserData.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import Foundation

// MARK: - UserData

struct User: Codable {
    let id, username, deviceToken, name: String
}

typealias UsersData = [User]
