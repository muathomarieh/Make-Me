//
//  FriendsView.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import SwiftUI

struct FriendsView: View {
    
    @Binding var showSignScreen: Bool
    @State var showFriendRequests: Bool = false
    @State var showAddFriend: Bool = false
    @State var text: String = ""
    @EnvironmentObject var appViewModel: AppViewModel
    
    //@StateObject var friendsViewModel: FriendsViewModel = FriendsViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Color.theme.accentToWhite),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            ).ignoresSafeArea()
            
            VStack {
                TopBarView(
                    showSignScreen: $showSignScreen, showFriendRequests: $showFriendRequests, badgeValue: appViewModel.notificationsCount, barType: .friends,
                    title: "Friends",
                    image: appViewModel.user?.image ?? ""
                )
                .sheet(isPresented: $showFriendRequests) {
                    friendRequestsView
                    .presentationDetents([.medium])
                }
                VStack {
                    List {
                        ForEach(appViewModel.friends) { friend in
                            FriendRowView(image: friend.image, name: friend.name)
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(.white)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .scrollIndicators(.hidden)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.bottom, 60)
            }
            .ignoresSafeArea()
            
            VStack {
                CircleAddButton {
                    showAddFriend.toggle()
                    print("Add friend button clicked")
                }
            }
        }
        .sheet(isPresented: $showAddFriend) {
            VStack {
                TextFieldView(placeHolder: "Email...", textFieldText: $appViewModel.addFriendEmail)
                AppButton(buttonTitle: "Add Friend", buttonClicked: {
                    do {
                        try appViewModel.friendRequest()
                        showAddFriend = false
                    } catch {
                        print(error)
                    }
                })
            }
            .padding()
            .presentationDetents([.height(150)])
        }
    }
}

extension FriendsView {
    var friendRequestsView: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Color.theme.accentToWhite),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            ).ignoresSafeArea()
            
            ScrollView {
                VStack {
                    if !appViewModel.friendRequests.isEmpty {
                        VStack {
                            Text("Friend requests.")
                                .font(.headline)
                                .foregroundStyle(.white)
                                                
                            ForEach(appViewModel.friendRequests) { request in
                                FriendReqestRowView(
                                    image: request.sender.image,
                                    name: request.sender.name,
                                    accepted: {
                                        appViewModel
                                            .friendRequestAccept(
                                                request: request
                                            )
                                    },
                                    rejected: {
                                        appViewModel
                                            .friendRequestReject(
                                                request: request
                                            )
                                    }
                                )
                            }
                        }
                    }
                                        
                    if !appViewModel.boardInvites.isEmpty {
                        VStack {
                            Text("Board invites.")
                                .font(.headline)
                                .foregroundStyle(.white)
                                                
                            ForEach(appViewModel.boardInvites) { invite in
                                BoardInviteRow(
                                    image: invite.sender.image,
                                    name: invite.sender.name,
                                    boardName: "") {
                                        appViewModel
                                            .boardsInviteAccept(invite: invite)
                                    } rejected: {
                                        appViewModel
                                            .boardsInviteReject(invite: invite)
                                    }
                            }
                        }
                    }
                                        
                    if appViewModel.friendRequests.isEmpty && appViewModel.boardInvites.isEmpty {
                        Text("No pending requests")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding()
        }
    }
}
#Preview {
    FriendsView(showSignScreen: .constant(false))
        .environmentObject(AppViewModel())
}
