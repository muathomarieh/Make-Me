//
//  SectionViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 28/03/2025.
//

import Foundation
import Combine

class SectionViewModel: ObservableObject {
    
    @Published var sections: [NewSection] = []
    @Published var friendRequests: [FriendRequest] = []
    @Published var boardID: String? = nil
    @Published var boardUsersIDs: [String] = []
    @Published var boardUsers: [NewUserModel] = []
    var cancellable = Set<AnyCancellable>()
    
  
    init(boardID: String, boardUsersIDs: [String]) {
        self.boardUsersIDs = boardUsersIDs
        self.boardID = boardID
        fetchSections()
        fetchBoardUsers()
    }
    // Fetch sections for a specific board
    func fetchSections()  {
        guard let boardID = boardID else {
            return
        }
        FirebaseFirestore.shared.fetchSections(boardID: boardID)
            .sink { _ in
                
            } receiveValue: { [weak self] sections in
                self?.sections = sections
                print(sections)
            }
            .store(in: &cancellable)
    }
    
    func addSection(title: String, for boardID: String) throws {
        let newSection = NewSection(sectionTitle: title)
        try FirebaseFirestore.shared
            .addSection(section: newSection, boardID: boardID)
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
