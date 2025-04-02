//
//  FriendsViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 29/03/2025.
//

import Foundation
import Combine

class FriendsViewModel: ObservableObject {

    @Published var friendRequests: [FriendRequest] = []
    var cancellable = Set<AnyCancellable>()
    
  
    init() {
        do {
            try fetchRequests()
        } catch {
            print("Failes to get friendRequests.")
        }
    }
    // Fetch sections for a specific board
    func fetchRequests()  throws {
        let user = try AuthenticationManager.shared.getAuthenticatedUser()
        FirebaseFirestore.shared.fetchFriendRequests(userID: user.uid)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] requests in
                self?.friendRequests = requests
                print(requests)
            })
            .store(in: &cancellable)

    }
}
