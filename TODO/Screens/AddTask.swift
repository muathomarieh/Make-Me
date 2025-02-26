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
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
    // INPUT
    @State var textFieldText: String = ""
    @State var textEditorText: String = ""
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
        ScrollView {
            VStack(spacing: 20) {
                textFieldView
                
                textEditorView
                
                if showTimePicker {
                    timePickerView
                }
                
                VStack {
                    AppButton(buttonTitle: showTimePicker ? "Cancel" : "Pick Start time") {
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
            
        }
        .navigationTitle(selectedSection.sectionTitle)
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok", role: .cancel) {
                alertTitle = ""
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
                    for: selectedSection
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

// MARK: VIEWS
extension AddTask {
    
    var textEditorView: some View {
        ZStack(alignment: .center) {
                   
            TextEditor(text: $textEditorText)
                .font(.headline)
                .scrollContentBackground(.hidden)
                .frame(height: 200)
                .padding()
                .background(.ultraThickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if textEditorText.isEmpty {
                Text("Task Description...")
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
    
    var textFieldView: some View {
        TextField("Type Task Title...", text: $textFieldText)
            .font(.headline)
            .frame(height: 55)
            .padding(.horizontal)
            .background(.ultraThickMaterial)
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
        AddTask(
            selectedSection: SectionModel(
sectionTitle: "Section2",
sectionItems: [
    ItemModel(
        title: "Item4",
        description: "desc4",
        startingTime: nil,
        isCompleted: false, remindMe: false
    ),
    ItemModel(title: "Item5", description: "desc5", startingTime: nil,isCompleted: false, remindMe: false),
    ItemModel(title: "Item6", description: "desc6", startingTime: nil,isCompleted: false, remindMe: false),
]
            )
        )
    }
    .environment(ListViewModel())
}
