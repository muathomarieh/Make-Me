//
//  CreateNewBoardView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct CreateNewBoardView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var textFieldText: String = ""
    @State var pickedImage: String = "testImage"
    @State var pickedImageIndex: Int = 0   // remove when get the images
    
    var body: some View {
        VStack {
            TextFieldView(placeHolder: "Type Board Name...", textFieldText: $textFieldText)
          
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<25) { index in
                        Image("testImage")
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
                                    .stroke(pickedImageIndex == index ? Color.accentColor : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                pickedImageIndex = index
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            AppButton(buttonTitle: "New Board") {
                do {
                    let user = try AuthenticationManager.shared.getAuthenticatedUser()
                    try BoardsManager.shared.addBoard(boardName: textFieldText, boardImage: pickedImage, userID: user.uid)
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
