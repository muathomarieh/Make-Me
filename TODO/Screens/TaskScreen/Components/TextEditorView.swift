//
//  TextEditorView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var textEditorText: String
    var placeholder: String = "Task Description..."
    var placeholderColor: Color = .gray
    var textColor: Color = .black

    var body: some View {
        ZStack(alignment: .topLeading) {
            if textEditorText.isEmpty {
                Text(placeholder)
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            }
            
            TextEditor(text: $textEditorText)
                .font(.headline)
                .scrollContentBackground(.hidden)
                .frame(height: 220)
                .padding()
                .background(Color.appGray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(textColor)
        }
    }
}


#Preview {
    TextEditorView(textEditorText: .constant(""))
}
