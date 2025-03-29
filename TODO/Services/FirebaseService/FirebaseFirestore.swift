//
//  FirebaseFirestore.swift
//  TODO
//
//  Created by Muath Omarieh on 24/03/2025.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseFirestore

final class FirebaseFirestore {
    
    static let shared = FirebaseFirestore()
    
    private let db = Firestore.firestore()
    
    // MARK: Encoder/Decoder
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    private let decoder: Firestore.Decoder = {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    // MARK: DM
    // Creating
    func addUser(user: NewUserModel) async throws {
        try db
            .collection(Collections.users.rawValue)
            .document(user.id)
            .setData(from: user, encoder: encoder)
    }
    
    func addBoard(board: NewBoard, userID: String) throws {
        print("addBoard in firestore: \(board)")
        try db
            .collection(Collections.boards.rawValue)
            .document(board.id)
            .setData(from: board, encoder: encoder)
    }
    
    func addSection(section: NewSection, boardID: String) throws {
        print("addSection in Firestore: \(section), boardIndex: \(boardID)")
            
        try sectionCollection(boardID: boardID)
            .document(section.id)
            .setData(from: section, encoder: encoder)
    }
    
    
    func addTask(task: TaskModel, section: NewSection, boardID: String) throws {
        try taskCollection(boardID: boardID, sectionID: section.id)
            .document(task.id)
            .setData(from: task, encoder: encoder)
            
    }
    // deleting
    func deleteBoard(boardID: String, userID: String) {
        db.collection(Collections.boards.rawValue).document(boardID).delete()
    }
    func deleteSection(sectionID: String, boardID: String) {
        db.collection(Collections.boards.rawValue)
            .document(boardID)
            .collection(Collections.sections.rawValue)
            .document(sectionID)
            .delete()
    }
    func deleteTask(taskID: String, sectionID: String, boardID: String) {
        taskCollection(boardID: boardID, sectionID: sectionID)
            .document(taskID)
            .delete()
    }
    // Updating
    func updateBoardFavoriteState(boardID: String, state: Bool) {
        db.collection(Collections.boards.rawValue).document(boardID)
            .updateData([
                "is_favorite": !state
            ])
    }
    func updateTaskCompletedState(
        taskID: String,
        sectionID: String,
        boardID: String,
        state: Bool
    ) {
        taskCollection(boardID: boardID, sectionID: sectionID)
            .document(taskID)
            .updateData([
                "is_completed": !state
            ])
    }
    // MARK: Fetching
    func getUserData(userID: String) -> AnyPublisher<NewUserModel, Error> {
        let publisher = PassthroughSubject<NewUserModel, Error>()
        db
            .collection(Collections.users.rawValue)
            .document(userID)
            .addSnapshotListener { snapShot, error in
                guard let document = snapShot else {
                    return
                }
                let user = try! document.data(as: NewUserModel.self)
                print("user: \(user)")
                publisher.send(user)
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchYourBoards(userId: String) -> AnyPublisher<[NewBoard], Error> {
        let publisher = PassthroughSubject<[NewBoard], Error>()
        
        db.collection(Collections.boards.rawValue)
            .whereField("creator_id", isEqualTo: userId)
            .order(by: "date_created")
            .addSnapshotListener { snapshot, error in
                let boards: [NewBoard] = snapshot?.documents.compactMap({ document in
                    print("fetchYourBoards: \(document.documentID)")
                    return try? document
                        .data(as: NewBoard.self, decoder: self.decoder)
                }) ?? []
                publisher.send(boards)
                print("boards: \(boards)")
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchBoardsYouHaveAccesse(userId: String) -> AnyPublisher<[NewBoard], Error> {
        let publisher = PassthroughSubject<[NewBoard], Error>()
        
        db.collection(Collections.boards.rawValue)
            .whereField("board_users", arrayContains: userId)
            .order(by: "date_created")
            .addSnapshotListener { snapshot, error in
                let boards: [NewBoard] = snapshot?.documents.compactMap({ document in
                    print("fetchBoardsYouHaveAccesse: \(document.documentID)")
                    return try? document.data(as: NewBoard.self)
                }) ?? []
                publisher.send(boards)
                print("boards: \(boards)")
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSections(boardID: String) -> AnyPublisher<[NewSection], Error> {
        let publisher = PassthroughSubject<[NewSection], Error>()
        
        sectionCollection(boardID: boardID)
            .addSnapshotListener { snapshot, error in
                let sections: [NewSection] = snapshot?.documents.compactMap({ document in
                    print("fetchSections: \(document.documentID)")
                    return try? document
                        .data(as: NewSection.self, decoder: self.decoder)
                }) ?? []
                publisher.send(sections)
                print("sections: \(sections)")
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchTasksToSection(boardID: String, sectionID: String) -> AnyPublisher<[TaskModel], Error> {
        let publisher = PassthroughSubject<[TaskModel], Error>()
        
        taskCollection(boardID: boardID, sectionID: sectionID)
            .addSnapshotListener { snapshot, error in
                let boards: [TaskModel] = snapshot?.documents.compactMap({ document in
                    print("fetchTasksToSection: \(document.documentID)")
                    return try? document
                        .data(as: TaskModel.self, decoder: self.decoder)
                }) ?? []
                publisher.send(boards)
                print("boards: \(boards)")
            }
        return publisher.eraseToAnyPublisher()
    }

}

// MARK: Collections
extension FirebaseFirestore {
    
    func taskCollection(boardID: String, sectionID: String) -> CollectionReference {
        return db.collection(Collections.boards.rawValue)
            .document(boardID)
            .collection(Collections.sections.rawValue)
            .document(sectionID)
            .collection(Collections.tasks.rawValue)
    }
    
    func sectionCollection(boardID: String) -> CollectionReference {
        return db.collection(Collections.boards.rawValue)
            .document(boardID)
            .collection(Collections.sections.rawValue)
    }
    enum Collections: String {
        case users
        case boards
        case sections
        case tasks
    }

}


