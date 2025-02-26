//
//  AddView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(ListViewModel.self) var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color(UIColor.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button {
                    saveButtonPressed()
                } label: {
                    Text("Save".uppercased())
                        .foregroundStyle(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

            }
            .padding()
            
        }
        .navigationTitle("Add an Item 🖋️")
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok", role: .cancel) {
                alertTitle = ""
            }
        }
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
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
        AddView()
    }
    .environment(ListViewModel())
}
