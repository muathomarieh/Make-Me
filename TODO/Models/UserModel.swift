//
//  UserModel.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let name: String
    let boards: [String]
    let friends: [String]
    
    init(id: String, name: String, boards: [String] = [], friends: [String] = []) {
        self.id = id
        self.name = name
        self.boards = boards
        self.friends = friends
    }
}

struct BoardChanged: Identifiable, Codable {
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

    func toggleFavorite() -> BoardChanged {
        BoardChanged(
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

struct NewUserModel: Identifiable, Codable {
    let id: String
    let name: String
    let friends: [String]
    
    init(id: String, name: String, boards: [String] = [], friends: [String] = []) {
        self.id = id
        self.name = name
        self.friends = friends
    }
}

//struct BoardChanged: Identifiable, Codable {
//    var id: String?
//    let boardName: String
//    let boardImage: String
//    var isFavorite: Bool
//    var boardSections: [Section]
//    let boardOwner: String
//    let boardUsers: [String]
//
//    init(id: String? = nil,
//         boardName: String,
//         boardImage: String,
//         isFavorite: Bool = false,
//         boardSections: [Section] = [],
//         boardOwner: String,
//         boardUsers: [String]) {
//        self.id = id
//        self.boardName = boardName
//        self.boardImage = boardImage
//        self.isFavorite = isFavorite
//        self.boardSections = boardSections
//        self.boardOwner = boardOwner
//        self.boardUsers = boardUsers
//    }
//
//    func toggleFavorite() -> BoardChanged {
//        BoardChanged(
//            id: id,
//            boardName: boardName,
//            boardImage: boardImage,
//            isFavorite: !isFavorite,
//            boardSections: boardSections,
//            boardOwner: boardOwner,
//            boardUsers: boardUsers
//        )
//    }
//}

//
/*
 firebase base function
 data service firebase service
 class to retrieve user, boards and friends data connected with the viewModel
  */
