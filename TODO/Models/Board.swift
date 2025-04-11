//
//  BoardModel.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI
import FirebaseFirestore

struct NewBoard: Identifiable, Codable, Hashable {
    let id: String
    let boardName: String
    let boardImage: String
    let isFavorite: Bool
    let creatorId: String
    let boardUsers: [String]
    let dateCreated: Timestamp
        
    init(id: String = UUID().uuidString, boardName: String, boardImage: String, isFavorite: Bool = false, creatorId: String, boardUsers: [String] = [], dateCreated: Timestamp = Timestamp()) {
        self.id = id
        self.boardName = boardName
        self.boardImage = boardImage
        self.isFavorite = isFavorite
        self.creatorId = creatorId
        self.boardUsers = boardUsers
        self.dateCreated = dateCreated
    }
}
