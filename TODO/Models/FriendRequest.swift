//
//  FriendRequest.swift
//  TODO
//
//  Created by Muath Omarieh on 29/03/2025.
//

import Foundation

struct FriendRequest: Codable, Identifiable {
    let id: String
    let sender: NewUserModel
    let reciever: NewUserModel
}

struct FriendBoardInvite: Codable, Identifiable {
    let id: String
    let boardId: String
    let sender: NewUserModel
    let reciever: NewUserModel
}
