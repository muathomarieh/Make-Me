//
//  ItemModel.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation

// Immutable Struct
struct ItemModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let description: String
    let startingTime: Date?
    let isCompleted: Bool
    let remindMe: Bool
    let priority: String?
    
    init(id: String = UUID().uuidString, title: String, description: String, startingTime: Date?,isCompleted: Bool, remindMe: Bool, priority: String? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.startingTime = startingTime
        self.isCompleted = isCompleted
        self.remindMe = remindMe
        self.priority = priority
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, description: description, startingTime: startingTime, isCompleted: !isCompleted, remindMe: remindMe, priority: priority)
    }
    
    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?, newRemindMeState: Bool, newPriority: String?) -> ItemModel {
        return ItemModel(id: id, title: newTitle, description: newDescription, startingTime: newStartingTime ?? startingTime, isCompleted: isCompleted, remindMe: newRemindMeState, priority: newPriority)
    }
}
