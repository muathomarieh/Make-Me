//
//  BoardView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct BoardAccessedCardView: View {
    
    let board: NewBoard
    let favoriteClicked: () -> Void
    
    init(board: NewBoard, favoriteClicked: @escaping () -> Void) {
        self.board = board
        self.favoriteClicked = favoriteClicked
    }
    var body: some View {
        ZStack {
         
            BoardCardImageView(image: board.boardImage)
            
            BoardCardNameView(boardName: board.boardName)
            
            BoardCardFavoriteView(isFavorite: board.isFavorite)
                .onTapGesture {
                    favoriteClicked()
                }
            BoardCardUsersView(board: board)

        }
    }
}

#Preview {
    BoardAccessedCardView(board: NewBoard(boardName: "", boardImage: "", creatorId: "")) {
        
    } 
}
