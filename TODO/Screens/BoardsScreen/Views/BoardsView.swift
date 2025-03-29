//
//  BoardsView.swift
//  TODO
//
//  Created by Muath Omarieh on 26/02/2025.
//

import SwiftUI

struct BoardsView: View {
    
    @StateObject var vm: BoardsViewModel = BoardsViewModel()
    
    @State var text: String = ""
    @State var isFavorite: Bool = true
    @State var showListSectionView: Bool = false
    @State var showAddBoardView: Bool = false
    @State var selectedBoard: NewBoard? = nil
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Color.theme.accentToWhite),
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
                            LabelledDivider(label: "Yours", color: .white)
                            ForEach(vm.yourBoards) { board in
                                BoardCardView(
                                    boardName: board.boardName,
                                    imageName: board.boardImage,
                                    isFavorite: board.isFavorite
                                ) {
                                    vm.updateBoardFavoriteState(boardID: board.id, state: board.isFavorite)
                                }
                                .onTapGesture {
                                    selectedBoard = board
                                    showListSectionView = true
                                }
                                .contextMenu {
                                    
                                    Text("delete board")
                                }
                            }
                            LabelledDivider(label: "YouJoined", color: .white)
                            ForEach(vm.haveAccessboards) { board in
                                BoardCardView(
                                    boardName: board.boardName,
                                    imageName: board.boardImage,
                                    isFavorite: board.isFavorite
                                ) {
                                    vm.updateBoardFavoriteState(boardID: board.id, state: board.isFavorite)
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
                    ListSectionView(board: selectedBoard)
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
        .environmentObject(ListViewModel())
}
