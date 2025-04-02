//
//  FirebaseAuth.swift
//  TODO
//
//  Created by Muath Omarieh on 24/03/2025.
//

import Foundation
import FirebaseAuth

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private init() { }
    
    func getAuthenticatedUser() throws -> User {
        guard let user = Auth.auth().currentUser else {
            throw TODOErrors.invalidAuthenticatedUser
        }
        print(user.uid)
        return user
    }
    
    func createUser(email: String, password: String, name: String, image: String) async throws {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        try await FirebaseFirestore.shared.addUser(user: NewUserModel(id: authDataResult.user.uid, name: name, email: email, image: image))

    }
    
    func signInUser(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    
}

// MARK: Google
extension AuthenticationManager {
    
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken,
                                                       accessToken: tokens.accessToken)
        try await signIn(credential: credential, name: tokens.name, email: tokens.email, image: "testImage")
    }
    
    func signIn(credential: AuthCredential, name: String, email: String, image: String) async throws {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        try await FirebaseFirestore.shared.addUser(user: NewUserModel(id: authDataResult.user.uid, name: name, email: email, image: image))
        print(authDataResult.user.uid)
        print(name)
    }
}
