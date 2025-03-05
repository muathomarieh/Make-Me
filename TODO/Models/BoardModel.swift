//
//  BoardModel.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct BoardModel: Identifiable, Codable {
    let id: String
    let boardName: String
    let boardImage: String
    let isFavorite: Bool
    var boardSections: [SectionModel]
    
    init(id: String = UUID().uuidString, boardName: String, boardImage: String, isFavorite: Bool = false, boardSections: [SectionModel] = []) {
        self.id = id
        self.boardName = boardName
        self.boardImage = boardImage
        self.isFavorite = isFavorite
        self.boardSections = boardSections
    }
    
    func updateCompletion() -> BoardModel {
        return BoardModel(id: id, boardName: boardName, boardImage: boardImage, isFavorite: !isFavorite, boardSections: boardSections)
    }
}
