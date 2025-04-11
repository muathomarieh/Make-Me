//
//  SectionModel.swift
//  TODO
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation

struct NewSection: Identifiable, Codable, Hashable, Equatable {
    static func == (lhs: NewSection, rhs: NewSection) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let sectionTitle: String
    
    init(id: String = UUID().uuidString, sectionTitle: String) {
        self.sectionTitle = sectionTitle
        self.id = id
    }
    
}
