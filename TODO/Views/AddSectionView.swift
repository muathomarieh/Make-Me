//
//  AddView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct AddSectionView: View {
    
    let inBoard: BoardModel
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextFieldView(placeHolder: "Section Title..." ,textFieldText: $textFieldText)
                AppButton(buttonTitle: "Save".uppercased()) {
                    saveButtonPressed()
                }
            }
            .padding()
            
        }
        .navigationTitle("Add New Section 📨")
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok", role: .cancel) {
                alertTitle = ""
            }
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addSection(title: textFieldText, for: inBoard)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 || textFieldText.count > 8{
            alertTitle = "Your new todo item must be 3-8 characters long 😃"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    
}

#Preview {
    NavigationView {
        AddSectionView(inBoard: BoardModel(boardName: "BoardTestname", boardImage: "testImage"))
    }
    .environment(ListViewModel())
}

