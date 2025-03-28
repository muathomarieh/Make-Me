////
////  FirebaseService.swift
////  TODO
////
////  Created by Muath Omarieh on 17/03/2025.
////
//
//import Foundation
//import FirebaseFirestoreSwift
//import Firebase
//
//// MARK: - User Model
//struct User: Identifiable, Codable {
//    @DocumentID var id: String?
//    let name: String
//    let email: String
//    let profilePicture: String?
//    var friends: [String]? // Array of friend user IDs
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, email, profilePicture = "profile_picture", friends
//    }
//}
//
//// MARK: - Friend Request Model
//struct FriendRequest: Identifiable, Codable {
//    @DocumentID var id: String?
//    let senderId: String
//    let receiverId: String
//    var status: RequestStatus
//    let createdAt: Date
//    
//    enum CodingKeys: String, CodingKey {
//        case id, senderId = "sender_id", receiverId = "receiver_id",
//             status, createdAt = "created_at"
//    }
//}
//
//enum RequestStatus: String, Codable {
//    case pending, accepted, rejected
//}
//
//// MARK: - Board Model
//struct Board: Identifiable, Codable {
//    @DocumentID var id: String?
//    let name: String
//    let ownerId: String
//    let createdAt: Date
//    var members: [String]? // Array of member user IDs
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, ownerId = "owner_id", createdAt = "created_at", members
//    }
//}
//
//// MARK: - Todo Model
//struct Todo: Identifiable, Codable {
//    @DocumentID var id: String?
//    let title: String
//    let description: String
//    let dueDate: Date
//    var completed: Bool
//    let createdBy: String
//    let createdAt: Date
//    
//    enum CodingKeys: String, CodingKey {
//        case id, title, description, dueDate = "due_date",
//             completed, createdBy = "created_by", createdAt = "created_at"
//    }
//}
//
//// MARK: - Board Member Role
//struct BoardMember: Codable {
//    let userId: String
//    let role: MemberRole
//    
//    enum CodingKeys: String, CodingKey {
//        case userId = "user_id", role
//    }
//}
//
//enum MemberRole: String, Codable {
//    case owner, editor, viewer
//}
//
//
/////
/////
/////
//import Firebase
//import Combine
//
//class FirestoreManager: ObservableObject {
//    static let shared = FirestoreManager()
//    private let db = Firestore.firestore()
//    
//    // MARK: - User Operations
//    func createUser(user: User, completion: @escaping (Result<String, Error>) -> Void) {
//        do {
//            let ref = try db.collection("users").addDocument(from: user)
//            completion(.success(ref.documentID))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    // MARK: - Friend Operations
//    func sendFriendRequest(senderId: String, receiverEmail: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        // Implementation to find user by email and create request
//    }
//    
//    func acceptFriendRequest(requestId: String, completion: @escaping (Result<Void, Error>) -> Void) {
//        let batch = db.batch()
//        
//        // Update request status
//        let requestRef = db.collection("friendRequests").document(requestId)
//        batch.updateData(["status": "accepted"], forDocument: requestRef)
//        
//        // Add friends to both users
//        db.collection("friendRequests").document(requestId).getDocument { snapshot, _ in
//            guard let data = snapshot?.data(),
//                  let senderId = data["senderId"] as? String,
//                  let receiverId = data["receiverId"] as? String else { return }
//            
//            let senderRef = self.db.collection("users").document(senderId)
//            let receiverRef = self.db.collection("users").document(receiverId)
//            
//            batch.updateData(["friends": FieldValue.arrayUnion([receiverId])], forDocument: senderRef)
//            batch.updateData(["friends": FieldValue.arrayUnion([senderId])], forDocument: receiverRef)
//            
//            batch.commit { error in
//                error == nil ? completion(.success(())) : completion(.failure(error!))
//            }
//        }
//    }
//    
//    // MARK: - Board Operations
//    func createBoard(name: String, ownerId: String, completion: @escaping (Result<String, Error>) -> Void) {
//        let board = Board(
//            name: name,
//            ownerId: ownerId,
//            createdAt: Date(),
//            members: [ownerId]
//        )
//        
//        do {
//            let ref = try db.collection("boards").addDocument(from: board)
//            completion(.success(ref.documentID))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    func addMemberToBoard(boardId: String, userId: String, role: MemberRole, completion: @escaping (Result<Void, Error>) -> Void) {
//        let member = BoardMember(userId: userId, role: role)
//        
//        do {
//            try db.collection("boards").document(boardId)
//                .collection("members").document(userId)
//                .setData(from: member)
//            
//            db.collection("boards").document(boardId).updateData([
//                "members": FieldValue.arrayUnion([userId])
//            ])
//            
//            completion(.success(()))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//    
//    // MARK: - Todo Operations
//    func createTodo(boardId: String, todo: Todo, completion: @escaping (Result<String, Error>) -> Void) {
//        do {
//            let ref = try db.collection("boards").document(boardId)
//                .collection("todos").addDocument(from: todo)
//            completion(.success(ref.documentID))
//        } catch let error {
//            completion(.failure(error))
//        }
//    }
//}
//
//
//// Get current user's boards
//func fetchUserBoards(userId: String) {
//    Firestore.firestore().collection("boards")
//        .whereField("members", arrayContains: userId)
//        .addSnapshotListener { snapshot, error in
//            // Handle boards
//        }
//}
//
//// Get pending friend requests
//func fetchPendingRequests(userId: String) {
//    Firestore.firestore().collection("friendRequests")
//        .whereField("receiverId", isEqualTo: userId)
//        .whereField("status", isEqualTo: "pending")
//        .addSnapshotListener { snapshot, error in
//            // Handle requests
//        }
//}
//
//// Update todo status
//func toggleTodoCompletion(boardId: String, todoId: String) {
//    Firestore.firestore().collection("boards").document(boardId)
//        .collection("todos").document(todoId)
//        .updateData(["completed": FieldValue.increment(Int64(1))])
//}
