//
//  BoardsView.swift
//  TODO
//
//  Created by Muath Omarieh on 26/02/2025.
//

import SwiftUI

struct BoardsView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    //@StateObject var appViewModel: BoardsViewModel = BoardsViewModel()
    
    @State var isFavorite: Bool = true
    @State var showAddBoardView: Bool = false
    @State var selectedBoard: NewBoard? = nil
    @State var selectedBoardToAddUserTo: NewBoard? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: Color.theme.accentToWhite),
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                )
                .ignoresSafeArea()
                VStack(spacing: 0) {
                    TopBarView(showSignScreen: .constant(false), showFriendRequests: .constant(false), badgeValue: 0, barType: .boards, title: "BOARDS", image: appViewModel.user?.image ?? "testImage")
                        .ignoresSafeArea(.container, edges: .top)
                    
                    VStack {
                        TextFieldView(
                            placeHolder: "Search for a board...",
                            textFieldText: $appViewModel.searchText
                        )
                        .offset(y: -20)
                        
                        ScrollView {
                            VStack(spacing: 20) {
                                if !appViewModel.yourBoards.isEmpty {
                                    LabelledDivider(label: "Yours", color: .white)
                                }
                                ForEach(appViewModel.yourBoards) { board in
                                    BoardCardView(
                                        board: board                                
                                    ) {
                                        appViewModel.updateBoardFavoriteState(boardID: board.id, state: board.isFavorite)
                                    } plusClicked: {
                                        selectedBoardToAddUserTo = board
                                    }
                                    .onTapGesture {
                                        selectedBoard = board
                                    }
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            appViewModel.deleteBoard(boardID: board.id)
                                        } label: {
                                            Text("Delete board.")
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                                if !appViewModel.haveAccessboards.isEmpty {
                                    LabelledDivider(label: "YouJoined", color: .white)
                                }
                                ForEach(appViewModel.haveAccessboards) { board in
                                    BoardAccessedCardView(
                                        board: board
                                    ) {
                                        appViewModel.updateBoardFavoriteState(boardID: board.id, state: board.isFavorite)
                                    } 
                                    .onTapGesture {
                                        selectedBoard = board
                                    }
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            appViewModel.leaveBoard(boardID: board.id)
                                        } label: {
                                            Text("Leave Board.")
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .sheet(item: $selectedBoardToAddUserTo) { board in
                        boardInvitesView(board: board)
                            .presentationDetents([.height(150)])
                    }
                    .padding(.horizontal)
                    
                }
                
                CircleAddButton {
                    showAddBoardView.toggle()
                }
                
            }
            .navigationDestination(item: $selectedBoard) { board in
                ListSectionView(board: board)
            }
            .sheet(isPresented: $showAddBoardView) {
                CreateNewBoardView()
                    .presentationDetents([.medium])
            }
        }
    }
}


extension BoardsView {
    func boardInvitesView(board: NewBoard) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Color.theme.accentToWhite),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            ).ignoresSafeArea()
            
            if !appViewModel.friends.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(appViewModel.friends) { friend in
                            VStack {
                                ProfileImageView(image: friend.image)
                                Text(friend.name)
                                    .foregroundStyle(.white)
                            }
                            .padding()
                            .onTapGesture {
                                do {
                                    try appViewModel.inviteFriendToBoard(reciever: friend, board: board)
                                    selectedBoardToAddUserTo = nil
                                } catch {
                                    print("inviteFriendToBoard Failed: \(error)")
                                }
                            }
                            .padding()
                        }
                    }
                }
            } else {
                Text("No friends to invite.").font(.headline)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    NavigationStack {
        BoardsView()
            .environmentObject(AppViewModel())
    }
}
