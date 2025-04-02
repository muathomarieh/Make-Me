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
    @Published var progress: Double = 0.0
  
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
                print(separator: "-")
                self?.updateProgress()
                print("progress: \(self?.progress)")
                print("Tasksssss: \(tasks)")
                print(separator: "-")
            }
            .store(in: &cancellable)
    }
    
    func updateTaskCompletedState(taskID: String, sectionID: String, boardID: String, state: Bool) {
        FirebaseFirestore.shared.updateTaskCompletedState(taskID: taskID, sectionID: sectionID, boardID: boardID, state: state)
        updateProgress()
    }
    
    func addItem(
        task: TaskModel
    ) throws {
        guard let boardID = boardID, let sectionID = sectionID else {
            return
        }
        let newOrder = tasks.count
        
        if let date = task.startingTime {
            if task.remindMe {
                NotificationManager.instance
                    .scheduleNotification(taskTitle: task.title, date: date, id: task.id)
            }
        }
        try FirebaseFirestore.shared.addTask(task: task, sectionID: sectionID, boardID: boardID)
        
    }
    
    func deleteTask(
        sectionID: String,
        boardID: String,
        indexSet: IndexSet
    ) {
        guard let index = indexSet.first else { return }
        let task = tasks[index]
        NotificationManager.instance.cancelNotification(to: task.id)
        FirebaseFirestore.shared.deleteTask(taskID: task.id, sectionID: sectionID, boardID: boardID)
    }
    
    func updateTask(task: TaskModel, secID: String) {
        guard let boardID = boardID else {
            return
        }
        FirebaseFirestore.shared.updateTask(sectionID: secID, boardID: boardID, task: task)
    }
//    func handleMove(from source: IndexSet, to destination: Int, sectionID: String, boardID: String) {
//        var reorderedTasks = tasks
//        reorderedTasks.move(fromOffsets: source, toOffset: destination)
//        
//        // Update order values based on new positions
//        for (index, task) in reorderedTasks.enumerated() {
//            let updatedTask = task.withUpdatedOrder(newOrder: index)
//            if updatedTask.order != task.order {
//                FirebaseFirestore.shared.updateTaskOrder(
//                    taskID: updatedTask.id,
//                    sectionID: sectionID,
//                    boardID: boardID,
//                    newOrder: updatedTask.order
//                )
//            }
//        }
//        
//        tasks = reorderedTasks // Optimistic UI update
//    }
    
    private func updateProgress() {
        let completedTasks = tasks.filter { $0.isCompleted }.count
        let totalTasks = tasks.count
        progress = totalTasks > 0 ? CGFloat(completedTasks) / CGFloat(
            totalTasks
        ) : 0.0
    }
}
