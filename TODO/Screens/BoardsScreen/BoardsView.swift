//
//  BoardsView.swift
//  TODO
//
//  Created by Muath Omarieh on 26/02/2025.
//

import SwiftUI

struct BoardsView: View {
    
    @Environment(ListViewModel.self) var listViewModel
    
    @State var text: String = ""
    @State var isFavorite: Bool = true
    @State var showListSectionView: Bool = false
    @State var showAddBoardView: Bool = false
    @State var selectedBoard: BoardModel? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Colors.accentToWhite),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            )
            .ignoresSafeArea()
            VStack(spacing: 0) {
                TopBarView(barType: .boards, title: "BOARDS", image: "testImage")
                    .ignoresSafeArea(.container, edges: .top)
                    
                VStack {
                    TextFieldView(
                        placeHolder: "Search for a board...",
                        textFieldText: $text
                    )
                    .offset(y: -20)
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(listViewModel.boards) { board in
                                BoardView(
                                    boardName: board.boardName,
                                    imageName: board.boardImage,
                                    isFavorite: board.isFavorite
                                ) {
                                    listViewModel
                                        .updateBoardFavoriteState(
                                            forBoard: board
                                        )
                                }
                                .onTapGesture {
                                    selectedBoard = board
                                    showListSectionView = true
                                }
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal)
                    
            }
            .navigationDestination(isPresented: $showListSectionView) {
                if let selectedBoard = selectedBoard {
                    ListSectionView(selectedBoard: selectedBoard)
                }
            }
                
            CircleAddButton {
                showAddBoardView.toggle()
            }
                
        }
        
        .sheet(isPresented: $showAddBoardView) {
            CreateNewBoardView()
                .presentationDetents([.medium])
        }
    }
}


#Preview {
    BoardsView()
        .environment(ListViewModel())
}
