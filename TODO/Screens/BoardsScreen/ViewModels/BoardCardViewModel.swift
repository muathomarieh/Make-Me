//
//  BoardCardViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 11/04/2025.
//

import Foundation
import Combine

class BoardCardViewModel: ObservableObject {
    @Published var boardUsers: [NewUserModel] = []
    var cancellable = Set<AnyCancellable>()
    var boardID: String? = nil
    
    init(boardID: String) {
        self.boardID = boardID
        fetchBoardUsers()
    }
    
    func fetchBoardUsers() {
        guard let boardID = boardID else {
            return
        }
        FirebaseFirestore.shared.observeBoardUsersIDs(boardID: boardID)
            .sink { board in
                FirebaseFirestore.shared.getUsersFromIDs(board.boardUsers)
                    .receive(on: DispatchQueue.main)
                    .sink { error in
                        print("Error fetching boardUsers: \(error)")
                    } receiveValue: { [weak self] boardUsers in
                        self?.boardUsers = boardUsers
                    }
                    .store(in: &self.cancellable)
            }
            .store(in: &self.cancellable)
    }
}
