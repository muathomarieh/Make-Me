//
//  TextEditorView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var textEditorText: String
    var body: some View {
        ZStack(alignment: .center) {
                   
            TextEditor(text: $textEditorText)
                .font(.headline)
                .scrollContentBackground(.hidden)
                .frame(height: 220)
                .padding()
                .background(Color.appGray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            if textEditorText.isEmpty {
                Text("Task Description...")
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
}

#Preview {
    TextEditorView(textEditorText: .constant(""))
}
