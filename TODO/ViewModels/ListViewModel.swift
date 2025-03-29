//
//  ListViewModel.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import Foundation
import SwiftUI
import Combine

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

//@Observable class ListViewModel {
//
//    var boards: [Board] = []{
//        didSet {
//            saveSections()
//            if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first {
//            }
//        }
//    }
//    
//    let itemsKey: String = "boards_list"
//    
//    init() {
//        getSections()
//    }
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
//    func addBoard(boardName: String, boardImage: String) {
//        let newBoard = Board(boardName: boardName, boardImage: boardImage)
//        boards.append(newBoard)
//    }
//    
//    func addSection(title: String, for board: Board) {
//        if let boardIndex = getBoardIndex(for: board) {
//            let newSection = Section(sectionTitle: title)
//            boards[boardIndex].boardSections.append(newSection)
//        }
//    }
//    
//    func addItem(
//        task: Task,
//        forSection section: Section,
//        forBoard board: Board
//    ) {
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
//    func updateItemCheckmark(task: Task, forSection section: Section, forBoard board: Board) {
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
//                           remindMe: Bool, priority: String?, item: Task, forSection section: Section, forBoard board: Board) {
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
//    func sectionForSelectedTask(_ task: Task, board: Board) -> Section? {
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


class ListViewModel: ObservableObject {
    
    @Published var boards: [Board] = []
    @Published var user: NewUserModel? = nil
    @Published var manager = BoardsManager.shared
    @Published var text = ""
    @Published var cancellable = Set<AnyCancellable>()
    
    init() {
        //getBoards()
       
    }
    
    // FireStore
    func userData() throws {
        
        let user = try AuthenticationManager.shared.getAuthenticatedUser()
        FirebaseFirestore.shared.getUserData(userID: user.uid)
            .receive(on: DispatchQueue.main)
            .sink { error in
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellable)

    }
    
    
//    func getBoards() {
//        
//        $text
//            .combineLatest(manager.$boards)
//            .receive(on: DispatchQueue.main)
//            .map(filterBoards)
//            .sink { [weak self] boards in
//                self?.boards = boards
//            }
//            .store(in: &cancellable)
//    }
    
    private func filterBoards(text: String, boards: [Board]) -> [Board] {
        guard !text.isEmpty else {
            return boards
        }
        
        let lowercassedText = text.lowercased()
        return boards.filter { board -> Bool in
            return board.boardName.lowercased().contains(lowercassedText)
        }
    }
    
//    // MARK: ADDING PART
//    func addBoard(boardName: String, boardImage: String) throws {
//        let user = try AuthenticationManager.shared.getAuthenticatedUser()
//        try manager.addBoard(boardName: boardName, boardImage: boardImage, userID: user.uid)
//    }
//    
//    func addSection(title: String, for board: Board) throws {
//        try manager.addSection(title: title, for: board)
//    }
//    
//    func addItem(
//        task: TaskModel,
//        forSection section: SectionModel,
//        forBoard board: Board
//    ) throws {
//        try manager.addItem(task: task, forSection: section, forBoard: board)
//    }
//    
//    
//    
//    // MARK: DELETE ITEM
//    func deleteItem(
//        for board: Board,
//        from section: SectionModel,
//        at indexSet: IndexSet
//    ) {
//        manager.deleteItem(for: board, from: section, at: indexSet)
//    }
//    
//    // MARK: MOVE ITEM
//    func moveItem(from: IndexSet, to: Int, for section: SectionModel, for board: Board) {
//        manager.moveItem(from: from, to: to, for: section, for: board)
//    }
//    
//    // MARK: UPDATE ITEM
//    func updateItemCheckmark(task: TaskModel, forSection section: SectionModel, forBoard board: Board) {
//        manager.updateItemCheckmark(task: task, forSection: section, forBoard: board)
//    }
//    
//    func updateItemContent(newTitle: String, newDescription: String, newStartingTime: Date?,
//                           remindMe: Bool, priority: String?, item: TaskModel, forSection section: SectionModel, forBoard board: Board) {
//        manager.updateItemContent(newTitle: newTitle, newDescription: newDescription, newStartingTime: newStartingTime, remindMe: remindMe, priority: priority, item: item, forSection: section, forBoard: board)
//    }
//    
//    // MARK: UPDATE BOARD
//    func updateBoardFavoriteState(forBoard board: Board) {
//        manager.updateBoardFavoriteState(forBoard: board)
//    }
//    
//    // MARK:
//    func completedFractions(for section: SectionModel) -> CGFloat {
//        return manager.completedFractions(for: section)
//    }
//    
//    
//    func isSectionsEmptyInTheBoard(for board: Board) -> Bool {
//        manager.isSectionsEmptyInTheBoard(for: board)
//    }
//    
//    func sectionForSelectedTask(_ task: TaskModel, board: Board) -> SectionModel? {
//        manager.sectionForSelectedTask(task, board: board)
//    }
//    
//    func getBoardIndex(for board: Board) -> Int {
//        if let boardIndex = boards.firstIndex(where: { $0.id == board.id }) {
//            return boardIndex
//        } else {
//            return 0
//        }
//    }
    
}
