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
        print("AddUser")
        try db
            .collection(Collections.users.rawValue)
            .document(user.id)
            .setData(from: user, encoder: encoder)
    }
    
    func updateUserProfileImage(image: String) {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            db
                .collection(Collections.users.rawValue)
                .document(user.uid)
                .updateData([
                    "image": image
                ])
        } catch {
            print("Change user profile image failed. \(error)")
        }
    }
    
    func addBoard(board: NewBoard) throws {
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
    
    
    func addTask(task: TaskModel, sectionID: String, boardID: String) throws {
        try taskCollection(boardID: boardID, sectionID: sectionID)
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
    
    func updateTask(
        sectionID: String,
        boardID: String,
        task: TaskModel
    ) {
        do {
            try taskCollection(boardID: boardID, sectionID: sectionID)
                .document(task.id)
                .setData(from: task, encoder: encoder)
        } catch {
            print("Updateing task failed: \(error)")
        }
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
                do {
                    let user = try document.data(as: NewUserModel.self)
                    print("user: \(user)")
                    publisher.send(user)
                } catch {
                    print(error)
                }
                
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
            .whereField("creator_id", isNotEqualTo: userId)
            .whereField("board_users", arrayContains: userId)
            .order(by: "date_created")
            .addSnapshotListener { snapshot, error in
                let boards: [NewBoard] = snapshot?.documents.compactMap({ document in
                    print("fetchBoardsYouHaveAccesse: \(document.documentID)")
                    return try? document.data(as: NewBoard.self, decoder: self.decoder)
                }) ?? []
                publisher.send(boards)
                print("fetchBoardsYouHaveAccesse: \(boards)")
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
    
    //friends
    func friendRequest(email: String, sender: NewUserModel) async -> String {
        do {
            print("Searching for user with email: \(email)")
            
            let document = try await db.collection(Collections.users.rawValue)
                .whereField("email", isEqualTo: email)
                .getDocuments()
            
            guard let reciever = try document.documents.first?.data(as: NewUserModel.self, decoder: decoder) else {
                print("User not found")
                return "User not found. Check email."
            }
            
            print("User found: \(reciever)")

            let friendRequestDocument = db.collection(Collections.friendRequests.rawValue)
                .document()
            
            try friendRequestDocument.setData(from: FriendRequest(id: friendRequestDocument.documentID, sender: sender, reciever: reciever), encoder: encoder)
            
            print("Friend request sent to: \(reciever.id)")
            return "Friend request sent!"
            
        } catch {
            print("Error adding friend: \(error.localizedDescription)")
            return "Failed to send request. Try again."
        }
    }

    func fetchFriendRequests(userID: String)  -> AnyPublisher<[FriendRequest], Error> {
        let publisher = PassthroughSubject<[FriendRequest], Error>()
        db.collection(Collections.friendRequests.rawValue).whereField("reciever.id", isEqualTo: userID)
            .addSnapshotListener { snapshot, error in
                let requests: [FriendRequest] = snapshot?.documents.compactMap({ document in
                    print("fetchFriendRequests: \(document.documentID)")
                    return try? document
                        .data(as: FriendRequest.self, decoder: self.decoder)
                    
                }) ?? []
                publisher.send(requests)
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func friendRequestAccept(request: FriendRequest) {
        db.collection(Collections.users.rawValue).document(request.sender.id)
            .updateData([
                "friends": FieldValue.arrayUnion([request.reciever.id])
            ])
        db.collection(Collections.users.rawValue).document(request.reciever.id)
            .updateData([
                "friends": FieldValue.arrayUnion([request.sender.id])
            ])
        db.collection(Collections.friendRequests.rawValue).document(request.id)
            .delete()
    }
    
    func friendRequestReject(request: FriendRequest) {
        db.collection(Collections.friendRequests.rawValue).document(request.id)
            .delete()
    }
    
    func getUsersFromIDs(_ friendIDs: [String]) ->  AnyPublisher<[NewUserModel], Error> {
        print("getUsersFromIDs: \(friendIDs)")
        let publisher = PassthroughSubject<[NewUserModel], Error>()
        
        guard !friendIDs.isEmpty else {
                publisher.send([])
                return publisher.eraseToAnyPublisher()
        }
        
        db.collection(Collections.users.rawValue)
            .whereField(FieldPath.documentID(), in: friendIDs)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents,
                      error == nil else {
                    print(
                        "Error fetching friends: \(error?.localizedDescription ?? "Unknown error")"
                    )
                    return
                }

                let friends: [NewUserModel] = documents.compactMap({ document in
                    print("fetchFriendRequests: \(document.documentID)")
                    return try? document
                        .data(as: NewUserModel.self, decoder: self.decoder)
                })
                publisher.send(friends)
            }
        return publisher.eraseToAnyPublisher()
    }
    
    //boardsInvites
    func inviteFriendToBoard(reciever: NewUserModel, sender: NewUserModel, boardID: String) async -> String {
        do {
            print("User found: \(reciever)")

            let friendRequestDocument = db.collection(Collections.boardInvites.rawValue)
                .document()
            
            try friendRequestDocument.setData(from: FriendBoardInvite(id: friendRequestDocument.documentID, boardId: boardID, sender: sender, reciever: reciever), encoder: encoder)
            
            print("Friend request sent to: \(reciever.id)")
            return "Friend request sent!"
            
        } catch {
            print("Error adding friend: \(error.localizedDescription)")
            return "Failed to send request. Try again."
        }
    }
    
    func fetchBoardsInvites(userID: String)  -> AnyPublisher<[FriendBoardInvite], Error> {
        let publisher = PassthroughSubject<[FriendBoardInvite], Error>()
        db.collection(Collections.boardInvites.rawValue).whereField("reciever.id", isEqualTo: userID)
            .addSnapshotListener { snapshot, error in
                let invites: [FriendBoardInvite] = snapshot?.documents.compactMap({ document in
                    print("fetchBoardsInvites: \(document.documentID)")
                    return try? document
                        .data(as: FriendBoardInvite.self, decoder: self.decoder)
                    
                }) ?? []
                print("Invites:: \(invites)")
                publisher.send(invites)
            }
        return publisher.eraseToAnyPublisher()
    }
    
    func boardsInviteAccept(invite: FriendBoardInvite) {
        db.collection(Collections.boards.rawValue).document(invite.boardId)
            .updateData([
                "board_users": FieldValue.arrayUnion([invite.reciever.id]),
                "board_users_images":  FieldValue.arrayUnion([invite.reciever.image])
            ])
        db.collection(Collections.boardInvites.rawValue).document(invite.id)
            .delete()
    }
    
    func boardsInviteReject(invite: FriendBoardInvite) {
        db.collection(Collections.boardInvites.rawValue).document(invite.id)
            .delete()
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
        case friendRequests
        case boardInvites
    }

}


