//
//  UserModel.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import Foundation

struct NewUserModel: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let image: String
    let friends: [String]
    
    init(id: String, name: String, email: String, image: String, friends: [String] = []) {
        self.id = id
        self.name = name
        self.email = email
        self.image = image
        self.friends = friends
    }
}

