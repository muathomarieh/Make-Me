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
    
    func addUser(user: UserModel) async throws {
        try db.collection(Collections.users.rawValue).document(user.id).setData(from: user, encoder: encoder)
    }
    
    func addBoard(board: Board, userID: String) throws {
        print("addBoard in firestore: \(board)")
        try db.collection(Collections.boards.rawValue).document(board.id).setData(from: board, encoder: encoder)
        
        db.collection(Collections.users.rawValue).document(userID).updateData([
            "boards": FieldValue.arrayUnion([board.id])
        ])
    }
    
    func addSection(section: Section, board: Board) throws {
        print("addSection in Firestore: \(section), boardIndex: \(board)")
            
        try db.collection(Collections.boards.rawValue)
                .document(board.id)
                .collection(Collections.sections.rawValue)
                .document(section.id)
                .setData(from: section, encoder: encoder)
    }
    
    func addTask(task: TaskModel, section: Section, board: Board) throws {
        try db.collection(Collections.boards.rawValue)
            .document(board.id)
            .collection(Collections.sections.rawValue)
            .document(section.id)
            .collection(Collections.tasks.rawValue)
            .document(task.id)
            .setData(from: task, encoder: encoder)
            
    }
    
    func getUserData(userID: String) -> AnyPublisher<UserModel, Error> {
        let publisher = PassthroughSubject<UserModel, Error>()
        db.collection(Collections.users.rawValue).document(userID).addSnapshotListener { snapShot, error in
            guard let document = snapShot else {
                return
            }
            let user = try! document.data(as: UserModel.self)
            print(user)
            publisher.send(user)
        }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchYourBoards(userId: String) -> AnyPublisher<[NewBoard], Error> {
        let publisher = PassthroughSubject<[NewBoard], Error>()
        
        db.collection(Collections.boards.rawValue)
            .whereField("creator_id", isEqualTo: userId)
            .addSnapshotListener { snapshot, error in
                let boards: [NewBoard] = snapshot?.documents.compactMap({ document in
                    print("fetchYourBoards: \(document.documentID)")
                    return try? document.data(as: NewBoard.self)
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
        
        db.collection(Collections.boards.rawValue)
            .document(boardID)
            .collection(Collections.sections.rawValue)
            .addSnapshotListener { snapshot, error in
                let sections: [NewSection] = snapshot?.documents.compactMap({ document in
                    print("fetchBoardsYouHaveAccesse: \(document.documentID)")
                    return try? document.data(as: NewSection.self)
                }) ?? []
                publisher.send(sections)
                print("sections: \(sections)")
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchTasksToSection(boardID: String, sectionID: String) -> AnyPublisher<[TaskModel], Error> {
        let publisher = PassthroughSubject<[TaskModel], Error>()
        
        db.collection(Collections.boards.rawValue)
            .document(boardID)
            .collection(Collections.sections.rawValue)
            .document(sectionID)
            .collection(Collections.tasks.rawValue)
            .addSnapshotListener { snapshot, error in
                let boards: [TaskModel] = snapshot?.documents.compactMap({ document in
                    print("fetchBoardsYouHaveAccesse: \(document.documentID)")
                    return try? document.data(as: TaskModel.self)
                }) ?? []
                publisher.send(boards)
                print("boards: \(boards)")
            }
        return publisher.eraseToAnyPublisher()
    }

}

enum Collections: String {
    case users
    case boards
    case sections
    case tasks
}

