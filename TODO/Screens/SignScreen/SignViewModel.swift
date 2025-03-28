//
//  SignViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 24/03/2025.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String
}

final class SignViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.createUser(email: email, password: password, name: name)
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No Email or password found.")
            return
        }
        
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    @MainActor
    func signInGoogle() async throws {
        
        guard let topVC = TopVC.shared.topViewController() else {
            throw TODOErrors.topVC
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        let userName = gidSignInResult.user.profile?.name
        let userGivenName = gidSignInResult.user.profile?.givenName
       
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.cannotFindHost)
        }
        
        let accessToken: String = gidSignInResult.user.accessToken.tokenString
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: userName ?? userGivenName ?? "Anonymous")
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
}
