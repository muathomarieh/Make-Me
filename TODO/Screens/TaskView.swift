//
//  TaskView.swift
//  TODO
//
//  Created by Muath Omarieh on 21/02/2025.
//

import SwiftUI

struct TaskView: View {
    
    // MARK: PROPERTIES
    let selectedTask: ItemModel
    let inSection: SectionModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
    // INPUT
    @State var textFieldText: String = ""
    @State var textEditorText: String = ""
    @State var remindMe: Bool = false
    // ALERT
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""    
    // TimePicker
    @State var pickerSelection: Date = Date()
    @State var showTimePicker: Bool = false
    
    // MARK: BODY
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                textFieldView
                textEditorView
                
                if showTimePicker {
                    timePickerView
                }
                
                VStack {
                    AppButton(buttonTitle: showTimePicker ? "Cancel" : "Pick Start time") {
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
        }
    }
    
    
}

// MARK: FUNCTIONS
extension TaskView {
    
    func updateButtonPressed() {
        if newTitleAppropriate() {
            listViewModel.updateItemContent(
                newTitle: textFieldText,
                newDescription: textEditorText,
                newStartingTime: showTimePicker ? pickerSelection : nil,
                remindMe: remindMe,
                item: selectedTask, for: inSection)
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

// MARK: VIEWS
extension TaskView {
    
    var textEditorView: some View {
        ZStack(alignment: .center) {
                   
            TextEditor(text: $textEditorText)
                .scrollContentBackground(.hidden)
                .lineSpacing(10)
                .frame(height: 200)
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if textEditorText.isEmpty {
                Text("Task Description...")
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
    
    var textFieldView: some View {
        TextField("Type Task Title...", text: $textFieldText)
            .frame(height: 55)
            .padding(.horizontal)
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var timePickerView: some View {
        VStack {
            DatePicker(selection: $pickerSelection) {
                Button("Remind Me") {
                    remindMe.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(remindMe ? Color.accentColor : Color.gray)
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationView {
        TaskView(
            selectedTask: ItemModel(title: "Item4", description: "desc4", startingTime: nil,isCompleted: false, remindMe: false),
            inSection: SectionModel(sectionTitle: "Section2", sectionItems: [
                ItemModel(title: "Item4", description: "desc4",startingTime: nil,isCompleted: false, remindMe: false),
            ])
        )
    }
    .environment(ListViewModel())
}
