//
//  ListViewModel.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation
import SwiftUI

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */
/*
@Observable class ListViewModel {

    var sections: [SectionModel] = []{
        didSet {
            saveSections()
            if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
                print(
                    "UserDefaults are stored at: \(url.appendingPathComponent("Preferences/com.yourapp.bundle-id.plist"))"
                )
            }
        }
    }
    let itemsKey: String = "sections_list"
    
    init() {
        getSections()
    }
     
    
    
    func addSection(title: String) {
        let newSection = SectionModel(sectionTitle: title)
        sections.append(newSection)
    }
    
    func addItem(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        startingTime: Date?,
        remindMe: Bool,
        for section: SectionModel
    ) {
        guard let pos = sections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        if let date = startingTime {
            if remindMe {
                NotificationManager.instance
                    .scheduleNotification(taskTitle: title, date: date, id: id)
            }
        }
        print(id)
        let newItem = ItemModel(
            id: id,
            title: title,
            description: description,
            startingTime: startingTime,
            isCompleted: false,
            remindMe: remindMe
        )
        sections[pos].sectionItems.append(newItem)
    }
    
    func getSections() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode(
                [SectionModel].self,
                from: data
            ) // [ItemModel].self we need the type not actual array
        else { return }
        sections = savedItems
    }
    
    func deleteItem(
        from section: SectionModel,
        at indexSet: IndexSet
    ) {
        guard let pos = sections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        // Get removed items before deleting
        let removedItems = indexSet.map { sections[pos].sectionItems[$0] }
        if let id = removedItems.first?.id {
            print("Deleted task id: \(id)")
            NotificationManager.instance.cancelNotification(to: id)
        }
        // Remove items
        sections[pos].sectionItems.remove(atOffsets: indexSet)

        // Remove the section if it's empty
        if sections[pos].sectionItems.isEmpty {
            sections.remove(at: pos)
        }
    }
    
    func moveItem(from: IndexSet, to: Int, for section: SectionModel) {
        
        guard let pos = sections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        sections[pos].sectionItems.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItemCheckmark(item: ItemModel, for section: SectionModel) {
            
        guard let pos = sections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        if let index = sections[pos].sectionItems.firstIndex(
            where: { $0.id == item.id
            }) {
            sections[pos].sectionItems[index] = item.updateCompletion()
        }
    }
    
    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?,
                           remindMe: Bool,item: ItemModel, for section: SectionModel) {
            
        guard let pos = sections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        if let date = newStartingTime {
            if remindMe {
                NotificationManager.instance.cancelNotification(to: item.id)
                NotificationManager.instance
                    .scheduleNotification(
                        taskTitle: newTitle,
                        date: date,
                        id: item.id
                    )
            } else {
                NotificationManager.instance.cancelNotification(to: item.id)
            }
        }
        
        if let index = sections[pos].sectionItems.firstIndex(
            where: { $0.id == item.id
            }) {
            sections[pos].sectionItems[index] = item
                .updateItemContent(newTitle: newTitle, newDescription: newDescription,
                                   newStartingTime: newStartingTime, newRemindMeState: remindMe)
        }
    }
    
    func saveSections() {
        if let encodedData = try? JSONEncoder().encode(sections) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func completedFractions(for section: SectionModel) -> CGFloat {
        let numberOfChecked = section.sectionItems.count(
            where: { $0.isCompleted == true
            })
        return (CGFloat(numberOfChecked) / CGFloat(section.sectionItems.count))
    }
}
 */
/////////////////////////////////////////////////////////////
///
///
///
///////////////////////////////////////////////////////////

@Observable class ListViewModel {

    var boards: [BoardModel] = []{
        didSet {
            saveSections()
            if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
                print(
                    "UserDefaults are stored at: \(url.appendingPathComponent("Preferences/com.yourapp.bundle-id.plist"))"
                )
            }
        }
    }
    let itemsKey: String = "boards_list"
    
    init() {
        getSections()
    }
    
    
    func getSections() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode(
                [BoardModel].self,
                from: data
            ) // [ItemModel].self we need the type not actual array
        else { return }
        boards = savedItems
    }
    
    // MARK: ADDING PART
    func addBoard(boardName: String, boardImage: String) {
        let newBoard = BoardModel(boardName: boardName, boardImage: boardImage)
        boards.append(newBoard)
    }
    
    func addSection(title: String, for board: BoardModel) {
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        let newSection = SectionModel(sectionTitle: title)
        boards[boardIndex].boardSections.append(newSection)
    }
    
    func addItem(
        id: String = UUID().uuidString,
        title: String,
        description: String,
        startingTime: Date?,
        remindMe: Bool,
        priority: String?,
        forSection section: SectionModel,
        forBoard board: BoardModel
    ) {
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        guard let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        if let date = startingTime {
            if remindMe {
                NotificationManager.instance
                    .scheduleNotification(taskTitle: title, date: date, id: id)
            }
        }
        print(id)
        let newItem = ItemModel(
            id: id,
            title: title,
            description: description,
            startingTime: startingTime,
            isCompleted: false,
            remindMe: remindMe,
            priority: priority
        )
        boards[boardIndex].boardSections[sectionIndex].sectionItems.append(newItem)
    }
    
    // MARK: DELETE ITEM
    func deleteItem(
        for board: BoardModel,
        from section: SectionModel,
        at indexSet: IndexSet
    ) {
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        guard let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        // Get removed items before deleting
        let removedItems = indexSet.map { boards[boardIndex].boardSections[sectionIndex].sectionItems[$0] }
        if let id = removedItems.first?.id {
            print("Deleted task id: \(id)")
            NotificationManager.instance.cancelNotification(to: id)
        }
        // Remove items
        boards[boardIndex].boardSections[sectionIndex].sectionItems.remove(atOffsets: indexSet)

        // Remove the section if it's empty
        if boards[boardIndex].boardSections[sectionIndex].sectionItems.isEmpty {
            boards[boardIndex].boardSections.remove(at: sectionIndex)
        }
    }
    
    // MARK: MOVE ITEM
    func moveItem(from: IndexSet, to: Int, for section: SectionModel, for board: BoardModel) {
        
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        guard let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        boards[boardIndex].boardSections[sectionIndex].sectionItems.move(fromOffsets: from, toOffset: to)
    }
    
    // MARK: UPDATE ITEM
    func updateItemCheckmark(item: ItemModel, forSection section: SectionModel, forBoard board: BoardModel) {
            
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        guard let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
            where: { $0.id == item.id
            }) {
            boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = item.updateCompletion()
        }
    }
    
    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?,
                           remindMe: Bool, priority: String?, item: ItemModel, forSection section: SectionModel, forBoard board: BoardModel) {
            
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        guard let sectionIndex = boards[boardIndex].boardSections.firstIndex(where: { $0.id == section.id }) else {
            return
        }
        
        if let date = newStartingTime {
            if remindMe {
                NotificationManager.instance.cancelNotification(to: item.id)
                NotificationManager.instance
                    .scheduleNotification(
                        taskTitle: newTitle,
                        date: date,
                        id: item.id
                    )
            } else {
                NotificationManager.instance.cancelNotification(to: item.id)
            }
        }
        
        if let itemIndex = boards[boardIndex].boardSections[sectionIndex].sectionItems.firstIndex(
            where: { $0.id == item.id
            }) {
            boards[boardIndex].boardSections[sectionIndex].sectionItems[itemIndex] = item
                .updateItemContent(newTitle: newTitle, newDescription: newDescription,
                                   newStartingTime: newStartingTime, newRemindMeState: remindMe, newPriority: priority)
        }
    }
    
    // MARK: UPDATE BOARD
    func updateBoardFavoriteState(forBoard board: BoardModel) {
            
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return
        }
        
        boards[boardIndex] = board.updateCompletion()

    }
    
    // MARK: SAVE
    func saveSections() {
        if let encodedData = try? JSONEncoder().encode(boards) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    // MARK: 
    func completedFractions(for section: SectionModel) -> CGFloat {
        let numberOfChecked = section.sectionItems.count(
            where: { $0.isCompleted == true
            })
        return (CGFloat(numberOfChecked) / CGFloat(section.sectionItems.count))
    }
    
    
    func isSectionsEmptyInTheBoard(for board: BoardModel) -> Bool {
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return false
        }
        
        return boards[boardIndex].boardSections.isEmpty
        
    }
    
    func sectionForSelectedTask(_ task: ItemModel, board: BoardModel) -> SectionModel? {
        // Logic to find the section containing the selected task
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return nil
        }
        return boards[boardIndex].boardSections.first { $0.sectionItems.contains(task) }
    }
    
    func getBoardIndex(for board: BoardModel) -> Int { // fix if not founded
        guard let boardIndex = boards.firstIndex(where: { $0.id == board.id }) else {
            return 0
        }
        return boardIndex
    }
}
