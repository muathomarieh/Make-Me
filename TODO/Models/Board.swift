//
//  BoardModel.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct Board: Identifiable, Codable {
    let id: String
    let boardName: String
    let boardImage: String
    let isFavorite: Bool
    var boardSections: [Section]
    
    init(id: String = UUID().uuidString, boardName: String, boardImage: String, isFavorite: Bool = false, boardSections: [Section] = []) {
        self.id = id
        self.boardName = boardName
        self.boardImage = boardImage
        self.isFavorite = isFavorite
        self.boardSections = boardSections
    }
    
    func updateCompletion() -> Board {
        return Board(id: id, boardName: boardName, boardImage: boardImage, isFavorite: !isFavorite, boardSections: boardSections)
    }
}


struct NewBoard: Identifiable, Codable, Hashable {
    let id: String
    let boardName: String
    let boardImage: String
    let isFavorite: Bool
    let creatorId: String
    let boardUsers: [String]
        
    init(id: String = UUID().uuidString, boardName: String, boardImage: String, isFavorite: Bool = false, creatorId: String, boardUsers: [String] = []) {
        self.id = id
        self.boardName = boardName
        self.boardImage = boardImage
        self.isFavorite = isFavorite
        self.creatorId = creatorId
        self.boardUsers = boardUsers
    }
    
//    func updateCompletion() -> Board {
//        return Board(id: id, boardName: boardName, boardImage: boardImage, isFavorite: !isFavorite, boardSections: boardSections)
//    }
}
