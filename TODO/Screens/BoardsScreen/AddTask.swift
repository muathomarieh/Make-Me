//
//  AddView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct AddTask: View {
    
    // MARK: PROPERTIES
    let selectedSection: SectionModel
    let inBoard: BoardModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
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
                    colors: Colors.accentToWhite
                ),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            
            VStack {
                ListSectionTopBarView(title: selectedSection.sectionTitle, topBarType: .task) {
                    
                } xmarkClicked: {
                    dismiss()
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
            listViewModel
                .addItem(
                    id: taskId,
                    title: textFieldText,
                    description: textEditorText,
                    startingTime: showTimePicker ? pickerSelection : nil,
                    remindMe: remindMe,
                    priority: priority,
                    forSection: selectedSection,
                    forBoard: inBoard
                )
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
            selectedSection: SectionModel(
                sectionTitle: "Section2",
                sectionItems: [
                    ItemModel(
                        title: "Item4",
                        description: "desc4",
                        startingTime: nil,
                        isCompleted: false, remindMe: false, priority: Strings.Blue
                    ),
                    ItemModel(
                        title: "Item5",
                        description: "desc5",
                        startingTime: nil,
                        isCompleted: false,
                        remindMe: false, priority: Strings.Blue
                    ),
                    ItemModel(
                        title: "Item6",
                        description: "desc6",
                        startingTime: nil,
                        isCompleted: false,
                        remindMe: false, priority: Strings.Blue
                    ),
                ]
            ),
            inBoard: BoardModel(boardName: "BoardTestname", boardImage: "testImage")
        )
    }
    .environment(ListViewModel())
}

