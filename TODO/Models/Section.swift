//
//  SectionModel.swift
//  TODO
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation

struct Section: Identifiable, Codable, Hashable {
    static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let sectionTitle: String
    var sectionItems: [TaskModel]
    
    init(id: String = UUID().uuidString, sectionTitle: String, sectionItems: [TaskModel] = []) {
        self.sectionTitle = sectionTitle
        self.sectionItems = sectionItems
        self.id = id
    }
    
}

struct NewSection: Identifiable, Codable, Hashable {
//    static func == (lhs: Section, rhs: Section) -> Bool {
//        return lhs.id == rhs.id
//    }
    
    let id: String
    let sectionTitle: String
    
    init(id: String = UUID().uuidString, sectionTitle: String) {
        self.sectionTitle = sectionTitle
        self.id = id
    }
    
}
