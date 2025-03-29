//
//  AddView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct AddSectionView: View {
    
    let inBoard: NewBoard
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var listViewModel: ListViewModel
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
            do {
                try BoardsManager.shared.addSection(title: textFieldText, for: inBoard.id)
            } catch {
                print(error)
            }
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
        AddSectionView(inBoard: NewBoard(boardName: "", boardImage: "", creatorId: "1234"))
    }
    .environmentObject(ListViewModel())
}

