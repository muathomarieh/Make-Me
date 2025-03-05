//
//  UserModel.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let boards: [String]
    let friends: [String]
}

struct Board: Identifiable, Codable {
    var id: String?
    let boardName: String
    let boardImage: String
    var isFavorite: Bool
    var boardSections: [SectionModel]
    let boardOwner: String
    let boardUsers: [String]

    init(id: String? = nil,
         boardName: String,
         boardImage: String,
         isFavorite: Bool = false,
         boardSections: [SectionModel] = [],
         boardOwner: String,
         boardUsers: [String]) {
        self.id = id
        self.boardName = boardName
        self.boardImage = boardImage
        self.isFavorite = isFavorite
        self.boardSections = boardSections
        self.boardOwner = boardOwner
        self.boardUsers = boardUsers
    }

    func toggleFavorite() -> Board {
        Board(
            id: id,
            boardName: boardName,
            boardImage: boardImage,
            isFavorite: !isFavorite,
            boardSections: boardSections,
            boardOwner: boardOwner,
            boardUsers: boardUsers
        )
    }
}


//
/*
 firebase base function
 data service firebase service
 class to retrieve user and friends data connected with the viewModel archeticture
 
 */
