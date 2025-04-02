//
//  AddView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct AddTask: View {
    
    // MARK: PROPERTIES
    let section: NewSection
    let inBoard: NewBoard
    
    @Environment(\.dismiss) var dismiss
    // INPUT
    @State var textFieldText: String = ""
    @State var textEditorText: String = ""
    @State var priority: String? = nil
    // Alert
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    // TimePicker
    @State var pickerSelection: Date = Date()
    @State var showTimePicker: Bool = false
    @State var remindMe: Bool = false
    let taskId = UUID().uuidString
    
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
                ListSectionTopBarView(title: section.sectionTitle, topBarType: .task) {
                    
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
                            NotificationManager.instance.requestAuthorization()
                            withAnimation(.bouncy) {
                                showTimePicker.toggle()
                            }
                        }
                        
                        AppButton(buttonTitle: "Save") {
                            saveButtonPressed()
                        }
                    }
                    
                }
                .padding()
                Spacer()
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Ok", role: .cancel) {
                    alertTitle = ""
                }
            }
        }
    }
    
}

// MARK: FUNCTIONS
extension AddTask {
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            do {
                try BoardsManager.shared
                    .addItem(task:
                                TaskModel(title: textFieldText, description: textEditorText, startingTime: showTimePicker ? pickerSelection : nil, isCompleted: false, remindMe: remindMe, priority: priority),
                             forSection: section,
                             forBoard: inBoard.id)
            } catch {
                print(error)
            }
            dismiss()
        }
        
    }
    
    func textIsAppropriate() -> Bool {
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
        AddTask(
            section: NewSection(sectionTitle: "1234"),
            inBoard: NewBoard(boardName: "", boardImage: "testImage", creatorId: "124")
        )
    }
    .environmentObject(AppViewModel())
}

