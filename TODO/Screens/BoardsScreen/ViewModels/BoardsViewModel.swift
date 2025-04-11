//
//  BoardsViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 28/03/2025.
//

import Foundation
import Combine

class BoardsViewModel: ObservableObject {
    
    @Published var yourBoards: [NewBoard] = []
    @Published var haveAccessboards: [NewBoard] = []
    
    @Published var cancellable = Set<AnyCancellable>()
        
    init() {
        getYourBoards()
        getBoardsYouHaveAccessToo()
    }
    
    func getYourBoards() {
        print("getBoards")
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            FirebaseFirestore.shared.fetchYourBoards(userId: user.uid)
                .sink { _ in
                    
                } receiveValue: { [weak self] boards in
                    self?.yourBoards = boards
                    print(boards)
                }
                .store(in: &cancellable)

        } catch {
            print("Failed to get the user id in getBoards.")
        }
    }
    func getBoardsYouHaveAccessToo() {
        print("getBoards")
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            FirebaseFirestore.shared.fetchBoardsYouHaveAccesse(userId: user.uid)
                .sink { _ in
                    
                } receiveValue: { [weak self] boards in
                    self?.haveAccessboards = boards
                    print(boards)
                }
                .store(in: &cancellable)

        } catch {
            print("Failed to get the user id in getBoards.")
        }
    }
    
    func deleteBoard(boardID: String) {
        do {
            let user = try AuthenticationManager.shared.getAuthenticatedUser()
            FirebaseFirestore.shared.deleteBoard(boardID: boardID, userID: user.uid)
        } catch {
            print(print("Failed to get the user id in deleteBoard."))
        }
    }
    
    func updateBoardFavoriteState(boardID: String, state: Bool) {
        FirebaseFirestore.shared.updateBoardFavoriteState(boardID: boardID, state: state)
    }
    
}
