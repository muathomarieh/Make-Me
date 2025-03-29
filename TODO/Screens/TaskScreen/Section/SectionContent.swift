//
//  SectionContent.swift
//  TODO
//
//  Created by Muath Omarieh on 28/03/2025.
//

import SwiftUI

struct SectionContent: View {
    
    let section: NewSection
    let boardID: String
    
    @StateObject var taskVM: TasksViewModel
    init(section: NewSection, boardID: String) {
        self.section = section
        self.boardID = boardID
        _taskVM = StateObject(wrappedValue: TasksViewModel(boardID: boardID, sectionID: section.id))
    }
    var body: some View {
        ForEach(taskVM.tasks) { task in
                taskRow(for: task, in: section)
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button("Check") {
                            withAnimation {
                                taskVM.updateTaskCompletedState(taskID: task.id, sectionID: section.id, boardID: boardID, state: task.isCompleted)
                            }
                        }
                    }
            }
            .onDelete { indexSet in
                taskVM.deleteTask(sectionID: section.id, boardID: boardID, indexSet: indexSet)
            }
            .onMove { indexSet, destination in
                //handleMove(indexSet, destination, for: section)
            }
    }
    
    private func taskRow(for task: TaskModel, in section: NewSection) -> some View {
        Button {
            //selectedTask = task
        } label: {
            ListRowView(item: task) {
                withAnimation(.linear) {
                    taskVM.updateTaskCompletedState(taskID: task.id, sectionID: section.id, boardID: boardID, state: task.isCompleted)
                }
            }
        }
    }
}

#Preview {
    SectionContent(section: NewSection(id: "sd", sectionTitle: "NewSection"), boardID: "1234")
}
