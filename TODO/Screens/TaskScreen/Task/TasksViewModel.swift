//
//  TasksViewModel.swift
//  TODO
//
//  Created by Muath Omarieh on 28/03/2025.
//

import Foundation
import Combine

class TasksViewModel: ObservableObject {
    
    @Published var tasks: [TaskModel] = []
    var boardID: String? = nil
    var sectionID: String? = nil
    var cancellable = Set<AnyCancellable>()
    
  
    init(boardID: String, sectionID: String) {
        self.boardID = boardID
        self.sectionID = sectionID
        fetchSectionTasks()
    }
    
    func fetchSectionTasks() {
        guard let boardID = boardID, let sectionID = sectionID else {
            return
        }
        FirebaseFirestore.shared.fetchTasksToSection(boardID: boardID, sectionID: sectionID)
            .sink { _ in
                
            } receiveValue: { [weak self] tasks in
                self?.tasks = tasks
                print("Tasksssss: \(tasks)")
            }
            .store(in: &cancellable)
    }
    
    func updateTaskCompletedState(taskID: String, sectionID: String, boardID: String, state: Bool) {
        FirebaseFirestore.shared.updateTaskCompletedState(taskID: taskID, sectionID: sectionID, boardID: boardID, state: state)
    }
    
    func deleteTask(
        sectionID: String,
        boardID: String,
        indexSet: IndexSet
    ) {
        guard let index = indexSet.first else { return }
        let task = tasks[index]
        FirebaseFirestore.shared.deleteTask(taskID: task.id, sectionID: sectionID, boardID: boardID)
    }
}
