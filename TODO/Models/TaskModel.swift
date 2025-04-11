//
//  ItemModel.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation

// Immutable Struct
struct TaskModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let description: String
    let startingTime: Date?
    let isCompleted: Bool
    let remindMe: Bool
    let priority: String?
    let order: Int
    
    init(id: String = UUID().uuidString, title: String, description: String, startingTime: Date?,isCompleted: Bool, remindMe: Bool, priority: String? = nil, order: Int) {
        self.id = id
        self.title = title
        self.description = description
        self.startingTime = startingTime
        self.isCompleted = isCompleted
        self.remindMe = remindMe
        self.priority = priority
        self.order = order
    }
    
    func withUpdatedOrder(newOrder: Int) -> TaskModel {
            return TaskModel(
                id: id,
                title: title,
                description: description,
                startingTime: startingTime,
                isCompleted: isCompleted,
                remindMe: remindMe,
                priority: priority,
                order: newOrder
            )
        }
}
