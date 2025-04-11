//
//  BoardCardUsersView.swift
//  TODO
//
//  Created by Muath Omarieh on 11/04/2025.
//

import SwiftUI

struct BoardCardUsersView: View {
    
    @StateObject var cardVM: BoardCardViewModel
    init(board: NewBoard) {
        _cardVM = StateObject(wrappedValue: BoardCardViewModel(boardID: board.id))
    }
    
    var body: some View {
        ScrollView(.horizontal, content: {
            
            HStack {
                ForEach(cardVM.boardUsers) { user in
                    Image(user.image)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(.circle)
                }
            }
        })
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .frame(width: 150)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .bottomLeading)
        .padding()
    }
}

#Preview {
    BoardCardUsersView(board: NewBoard(boardName: "", boardImage: "", creatorId: ""))
}
