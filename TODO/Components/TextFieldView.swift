//
//  TextFieldView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TextFieldView: View {
    let placeHolder: String
    @Binding var textFieldText: String
    
    var placeholderColor: Color = .gray
    var textColor: Color = .black
    var body: some View {
        TextField("", text: $textFieldText, prompt: Text(placeHolder).foregroundColor(placeholderColor))
                   .frame(height: 55)
                   .padding(.horizontal)
                   .background(Color.appGray)
                   .clipShape(RoundedRectangle(cornerRadius: 10))
                   .tint(textColor)
                   .foregroundColor(textColor)
    }
}

#Preview {
    TextFieldView(placeHolder: "Section Title..." ,textFieldText: .constant(""))
}
