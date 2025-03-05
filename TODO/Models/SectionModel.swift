//
//  SectionModel.swift
//  TODO
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation

struct SectionModel: Identifiable, Codable, Hashable {
    static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let sectionTitle: String
    var sectionItems: [ItemModel]
    
    init(id: String = UUID().uuidString, sectionTitle: String, sectionItems: [ItemModel] = []) {
        self.sectionTitle = sectionTitle
        self.sectionItems = sectionItems
        self.id = id
    }
}
