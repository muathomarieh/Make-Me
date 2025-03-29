//
//  TaskView.swift
//  TODO
//
//  Created by Muath Omarieh on 21/02/2025.
//

import SwiftUI

struct TaskView: View {
    
    // MARK: PROPERTIES
    let selectedTask: TaskModel
    let inSection: SectionModel
    let inBoard: Board
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
    // INPUT
    @State var textFieldText: String = ""
    @State var textEditorText: String = ""
    @State var priority: String?
    @State var remindMe: Bool = false
    // ALERT
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""    
    // TimePicker
    @State var pickerSelection: Date = Date()
    @State var showTimePicker: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: Color.theme.accentToWhite
                ),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            VStack {
                ListSectionTopBarView(
                    title: selectedTask.title,
                    topBarType: .task
                ) {
                    
                }
                
                VStack(spacing: 20) {
                    TextFieldView(
                        placeHolder: "Type Task Title...",
                        textFieldText: $textFieldText
                    )
                    
                    HStack {
                        TextEditorView(textEditorText: $textEditorText)
                        PriorityView(selectedPriority: $priority)
                    }
                    if showTimePicker {
                        TimePickerReminderView(
                            pickerSelection: $pickerSelection,
                            remindMe: $remindMe
                        )
                    }
                    
                    VStack {
                        AppButton(
                            buttonTitle: showTimePicker ? "Cancel" : "Pick Start time"
                        ) {
                            withAnimation(.bouncy) {
                                showTimePicker.toggle()
                            }
                        }
                        AppButton(buttonTitle: "Update") {
                            updateButtonPressed()
                        }
                    }
                    
                }
                .padding()
                Spacer()
                
            }
            .navigationTitle(inSection.sectionTitle)
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Ok", role: .cancel) {
                    alertTitle = ""
                }
            }
            .onAppear {
                textFieldText = selectedTask.title
                textEditorText = selectedTask.description
                remindMe = selectedTask.remindMe
                if let taskStartingTime = selectedTask.startingTime {
                    pickerSelection = taskStartingTime
                }
                priority = selectedTask.priority
            }
        }
    }
}

// MARK: FUNCTIONS
extension TaskView {
    
    func updateButtonPressed() {
        if newTitleAppropriate() {
//            listViewModel.updateItemContent(
//                newTitle: textFieldText,
//                newDescription: textEditorText,
//                newStartingTime: showTimePicker ? pickerSelection : nil,
//                remindMe: remindMe, priority: priority,
//                item: selectedTask,
//                forSection: inSection,
//                forBoard: inBoard
//            )
            dismiss()
        }
        
    }
    
    func newTitleAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long 😃"
            showAlert.toggle()
            return false
        }
        return true
    }
 
    
}

#Preview {
    NavigationView {
        TaskView(
            selectedTask: TaskModel(
                title: "Item4",
                description: "desc4",
                startingTime: nil,
                isCompleted: false,
                remindMe: false, priority: Strings.Blue
            ),
            inSection: SectionModel(
                sectionTitle: "Section2",
                sectionItems: [
                    TaskModel(
                        title: "Item4",
                        description: "desc4",
                        startingTime: nil,
                        isCompleted: false,
                        remindMe: false, priority: Strings.Blue
                    ),
                ]
            ),
            inBoard: Board(
                boardName: "BoardTestname",
                boardImage: "testImage"
            )
        )
    }
    .environmentObject(ListViewModel())
}
