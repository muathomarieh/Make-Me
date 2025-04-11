//
//  BoardView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct BoardCardView: View {
    
    let board: NewBoard
    
    
    
    init(board: NewBoard, favoriteClicked: @escaping () -> Void, plusClicked: @escaping () -> Void) {
        self.board = board
        self.favoriteClicked = favoriteClicked
        self.plusClicked = plusClicked
    }
    
    let favoriteClicked: () -> Void
    let plusClicked: () -> Void
    
    var body: some View {
        ZStack {
         
            BoardCardImageView(image: board.boardImage)
    
            BoardCardNameView(boardName: board.boardName)
            
            BoardCardFavoriteView(isFavorite: board.isFavorite)
                .onTapGesture {
                    favoriteClicked()
                }
            
            Image(systemName: "plus")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .onTapGesture {
                    plusClicked()
                }
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topTrailing)
                .padding()
                
            BoardCardUsersView(board: board)

        }
    }
}

#Preview {
    BoardCardView(board: NewBoard(boardName: "BoardName", boardImage: "testImage", creatorId: "")) {
        
    } plusClicked: {
        
    }

}
