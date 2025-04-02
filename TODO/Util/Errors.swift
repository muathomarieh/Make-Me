//
//  Errors.swift
//  TODO
//
//  Created by Muath Omarieh on 24/03/2025.
//

import Foundation

enum TODOErrors: LocalizedError {
    case invalidAuthenticatedUser
    case failedToSignUp
    case failedToSignIn
    case topVC
    case invalidInput(reason: String)

    var errorDescription: String? {
        switch self {
        case .invalidAuthenticatedUser:
            return "Failed to get the authenticated user."
        case .topVC:
            return "TopVC error."
        case .invalidInput(let reason):
            return "Invalid input: \(reason)"
        case .failedToSignUp:
            return "Failed to sign up."
        case .failedToSignIn:
            return "Failed to signIn."
        }
    }
}
