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
    var body: some View {
        TextField(placeHolder, text: $textFieldText)
            .frame(height: 55)
            .padding(.horizontal)
            .background(Color.appGray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    @Previewable
    @State var textFieldText: String = ""
    TextFieldView(placeHolder: "Section Title..." ,textFieldText: $textFieldText)
}
