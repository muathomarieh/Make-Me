//
//  BoardsManager.swift
//  TODO
//
//  Created by Muath Omarieh on 10/03/2025.
//

import Foundation

//class BoardsManager {
//    
//    private let itemsKey: String = "boards_list"
//    static let shared = BoardsManager()
//
//    @Published var boards: [Board] = []{
//        didSet {
//            saveSections()
//        }
//    }
//        
//    init() {
//        getSections()
//    }
//    
//    
//    func getSections() {
//        guard
//            let data = UserDefaults.standard.data(forKey: itemsKey),
//            let savedItems = try? JSONDecoder().decode(
//                [Board].self,
//                from: data
//            ) // [ItemModel].self we need the type not actual array
//        else { return }
//        boards = savedItems
//    }
//    
//    // MARK: ADDING PART
//    func addBoard(boardName: String, boardImage: String, userID: String) throws {
//        let newBoard = Board(boardName: boardName, boardImage: boardImage)
//        try FirebaseFirestore.shared.addBoard(board: newBoard, userID: userID)
//        boards.append(newBoard)
//    }
//    
//    func addSection(title: String, for board: Board) throws {
//        if let boardIndex = getBoardIndex(for: board) {
//            let newSection = Section(sectionTitle: title)
//            try FirebaseFirestore.shared.addSection(section: newSection, board: board)
//            boards[boardIndex].boardSections.append(newSection)
//        }
//    }
//    
//    func addItem(
//        task: TaskModel,
//        forSection section: Section,
//        forBoard board: Board
//    ) throws {
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            let id = UUID().uuidString
//            
//            if let date = task.startingTime {
//                if task.remindMe {
//                    NotificationManager.instance
//                        .scheduleNotification(taskTitle: task.title, date: date, id: task.id)
//                }
//            }
//            print(id)
//            try FirebaseFirestore.shared.addTask(task: task, section: section, board: board)
//            boards[boardIndex].boardSections[sectionIndex].sectionItems.append(task)
//            
//        }
//    }
//    
//    
//    
//    // MARK: DELETE ITEM
//    func deleteItem(
//        for board: Board,
//        from section: Section,
//        at indexSet: IndexSet
//    ) {
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            // Get removed items before deleting
//            let removedItems = indexSet.map { boards[boardIndex].boardSections[sectionIndex].sectionItems[$0] }
//            if let id = removedItems.first?.id {
//                print("Deleted task id: \(id)")
//                NotificationManager.instance.cancelNotification(to: id)
//            }
//            // Remove items
//            boards[boardIndex].boardSections[sectionIndex].sectionItems.remove(atOffsets: indexSet)
//            
//            // Remove the section if it's empty
//            if boards[boardIndex].boardSections[sectionIndex].sectionItems.isEmpty {
//                boards[boardIndex].boardSections.remove(at: sectionIndex)
//            }
//        }
//    }
//    
//    // MARK: MOVE ITEM
//    func moveItem(from: IndexSet, to: Int, for section: Section, for board: Board) {
//        
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            boards[boardIndex].boardSections[sectionIndex].sectionItems.move(fromOffsets: from, toOffset: to)
//        }
//    }
//    
//    // MARK: UPDATE ITEM
//    func updateItemCheckmark(task: TaskModel, forSection section: Section, forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
//                where: { $0.id == task.id
//                }) {
//                boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = task.updateCompletion()
//            }
//        }
//    }
//    
//    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?,
//                           remindMe: Bool, priority: String?, item: TaskModel, forSection section: Section, forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            if let date = newStartingTime {
//                if remindMe {
//                    NotificationManager.instance.cancelNotification(to: item.id)
//                    NotificationManager.instance
//                        .scheduleNotification(
//                            taskTitle: newTitle,
//                            date: date,
//                            id: item.id
//                        )
//                } else {
//                    NotificationManager.instance.cancelNotification(to: item.id)
//                }
//            }
//            
//            if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
//                where: { $0.id == item.id
//                }) {
//                boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = item
//                    .updateItemContent(newTitle: newTitle, newDescription: newDescription,
//                                       newStartingTime: newStartingTime, newRemindMeState: remindMe, newPriority: priority)
//            }
//        }
//    }
//    
//    // MARK: UPDATE BOARD
//    func updateBoardFavoriteState(forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board) {
//            boards[boardIndex] = board.updateCompletion()
//        }
//
//    }
//    
//    // MARK: SAVE
//    func saveSections() {
//        if let encodedData = try? JSONEncoder().encode(boards) {
//            UserDefaults.standard.set(encodedData, forKey: itemsKey)
//        }
//    }
//    
//    // MARK:
//    func completedFractions(for section: Section) -> CGFloat {
//        let numberOfChecked = section.sectionItems.count(
//            where: { $0.isCompleted == true
//            })
//        return (CGFloat(numberOfChecked) / CGFloat(section.sectionItems.count))
//    }
//    
//    
//    func isSectionsEmptyInTheBoard(for board: Board) -> Bool {
//        if let boardIndex = getBoardIndex(for: board) {
//            return boards[boardIndex].boardSections.isEmpty
//        }
//        return true
//    }
//    
//    func sectionForSelectedTask(_ task: TaskModel, board: Board) -> Section? {
//        guard let boardIndex = getBoardIndex(for: board) else {
//            return nil
//        }
//        return boards[boardIndex].boardSections.first { $0.sectionItems.contains(task) }
//    }
//    
//    /// Function  to get board index using board as param
//    func getBoardIndex(for board: Board) -> Int? {
//        if let boardIndex = boards.firstIndex(where: { $0.id == board.id }) {
//            return boardIndex
//        } else {
//            return nil
//        }
//    }
//    
//    /// Function  to get section index using section and boardIndex as param
//    private func getSectionIndex(for section: Section, in boardIndex: Int) -> Int? {
//        if let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) {
//            return sectionIndex
//        } else {
//            return nil
//        }
//    }
//}

//
//  BoardsManager.swift
//  TODO
//
//  Created by Muath Omarieh on 10/03/2025.
//

import Foundation
import FirebaseFirestore

class BoardsManager {
    
    static let shared = BoardsManager()
    // MARK: ADDING PART
//    func addBoard(boardName: String, boardImage: String, userID: String) throws {
//        let newBoard = NewBoard(boardName: boardName, boardImage: "testImage", creatorId: userID)
//        try FirebaseFirestore.shared.addBoard(board: newBoard, userID: userID)
//    }
//    
//    func addSection(title: String, for boardID: String) throws {
//        let newSection = NewSection(sectionTitle: title)
//        try FirebaseFirestore.shared
//            .addSection(section: newSection, boardID: boardID)
//    }
    
    func addItem(
        task: TaskModel,
        forSection section: NewSection,
        forBoard boardID: String
    ) throws {
        let id = UUID().uuidString
        
        if let date = task.startingTime {
            if task.remindMe {
                NotificationManager.instance
                    .scheduleNotification(taskTitle: task.title, date: date, id: task.id)
            }
        }
        print(id)
        try FirebaseFirestore.shared.addTask(task: task, sectionID: section.id, boardID: boardID)
        
    }
    
    
    
//    // MARK: DELETE ITEM
//    func deleteItem(
//        for board: Board,
//        from section: Section,
//        at indexSet: IndexSet
//    ) {
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            // Get removed items before deleting
//            let removedItems = indexSet.map { boards[boardIndex].boardSections[sectionIndex].sectionItems[$0] }
//            if let id = removedItems.first?.id {
//                print("Deleted task id: \(id)")
//                NotificationManager.instance.cancelNotification(to: id)
//            }
//            // Remove items
//            boards[boardIndex].boardSections[sectionIndex].sectionItems.remove(atOffsets: indexSet)
//            
//            // Remove the section if it's empty
//            if boards[boardIndex].boardSections[sectionIndex].sectionItems.isEmpty {
//                boards[boardIndex].boardSections.remove(at: sectionIndex)
//            }
//        }
//    }
    
//    // MARK: MOVE ITEM
//    func moveItem(from: IndexSet, to: Int, for section: Section, for board: Board) {
//        
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            boards[boardIndex].boardSections[sectionIndex].sectionItems.move(fromOffsets: from, toOffset: to)
//        }
//    }
//    
//    // MARK: UPDATE ITEM
//    func updateItemCheckmark(task: TaskModel, forSection section: Section, forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
//                where: { $0.id == task.id
//                }) {
//                boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = task.updateCompletion()
//            }
//        }
//    }
    
//    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?,
//                           remindMe: Bool, priority: String?, item: TaskModel, forSection section: Section, forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board),
//           let sectionIndex = getSectionIndex(for: section, in: boardIndex) {
//            
//            if let date = newStartingTime {
//                if remindMe {
//                    NotificationManager.instance.cancelNotification(to: item.id)
//                    NotificationManager.instance
//                        .scheduleNotification(
//                            taskTitle: newTitle,
//                            date: date,
//                            id: item.id
//                        )
//                } else {
//                    NotificationManager.instance.cancelNotification(to: item.id)
//                }
//            }
//            
//            if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
//                where: { $0.id == item.id
//                }) {
//                boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = item
//                    .updateItemContent(newTitle: newTitle, newDescription: newDescription,
//                                       newStartingTime: newStartingTime, newRemindMeState: remindMe, newPriority: priority)
//            }
//        }
//    }
//    
//    // MARK: UPDATE BOARD
//    func updateBoardFavoriteState(forBoard board: Board) {
//            
//        if let boardIndex = getBoardIndex(for: board) {
//            boards[boardIndex] = board.updateCompletion()
//        }
//
//    }
//    
//    // MARK:
//    func completedFractions(for section: Section) -> CGFloat {
//        let numberOfChecked = section.sectionItems.count(
//            where: { $0.isCompleted == true
//            })
//        return (CGFloat(numberOfChecked) / CGFloat(section.sectionItems.count))
//    }
//    
//    
//    func isSectionsEmptyInTheBoard(for board: Board) -> Bool {
//        if let boardIndex = getBoardIndex(for: board) {
//            return boards[boardIndex].boardSections.isEmpty
//        }
//        return true
//    }
//    
//    func sectionForSelectedTask(_ task: TaskModel, board: Board) -> Section? {
//        guard let boardIndex = getBoardIndex(for: board) else {
//            return nil
//        }
//        return boards[boardIndex].boardSections.first { $0.sectionItems.contains(task) }
//    }
}

