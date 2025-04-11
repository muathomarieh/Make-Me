//
//  CreateNewBoardView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct CreateNewBoardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var appViewModel: AppViewModel
    @State var textFieldText: String = ""
    @State var pickedImage: String = "testImage"
    
    var body: some View {
        VStack {
            TextFieldView(placeHolder: "Type Board Name...", textFieldText: $textFieldText)
          
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Strings.boardImages, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .foregroundStyle(.gray)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 20)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(.black.opacity(0.3))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(pickedImage == image ? Color.accentColor : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                pickedImage = image
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            AppButton(buttonTitle: "New Board") {
                do {
                    try appViewModel.addBoard(boardName: textFieldText, boardImage: pickedImage)
                } catch {
                    print(error)
                }
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    CreateNewBoardView()
}
