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
    @Published var boardID: String? = nil
    var cancellable = Set<AnyCancellable>()
    
  
    init(boardID: String) {
        self.boardID = boardID
        fetchSections()
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
            }
            .store(in: &cancellable)

    }
    
    func sectionTasks(sectionID: String) {
        guard let boardID = boardID else {
            return
        }
        FirebaseFirestore.shared.fetchTasksToSection(boardID: boardID, sectionID: section)
            .sink { _ in
                
            } receiveValue: { [weak self] sections in
                self?.sections = sections
            }
            .store(in: &cancellable)
    }
}
