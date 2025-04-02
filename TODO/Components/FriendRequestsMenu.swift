////
////  FriendRequestsMenu.swift
////  TODO
////
////  Created by Muath Omarieh on 29/03/2025.
////

import SwiftUI

struct FriendRequest2: Identifiable {
    let id: String
    let name: String
}

struct FriendRequestsMenu: View {
    @State private var friendRequests: [FriendRequest2] = [
        FriendRequest2(id: "1", name: "Ahmed"),
        FriendRequest2(id: "2", name: "Fatima"),
        FriendRequest2(id: "3", name: "Omar")
    ]
    
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    withAnimation(.spring()) {
                        showMenu.toggle()
                    }
                } label: {
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.primary)
                }
                .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if showMenu {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Friend Requests")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if friendRequests.isEmpty {
                        Text("No pending requests")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        List(friendRequests) { request in
                            HStack {
                                Text(request.name)
                                Spacer()
                                Button(action: { acceptRequest(request) }) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                Button(action: { declineRequest(request) }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.vertical, 4)
                        }
                        .frame(height: CGFloat(min(friendRequests.count * 50, 200))) // Limits height
                        .scrollContentBackground(.hidden)
                    }
                }
                .frame(width: 260)
                .padding(.vertical, 10)
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
                .offset(y: 120)
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
            }
        }
        .background(
            showMenu ? Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation { showMenu = false }
                } : nil
        )
    }
    
    private func acceptRequest(_ request: FriendRequest2) {
        withAnimation {
            friendRequests.removeAll { $0.id == request.id }
        }
    }
    
    private func declineRequest(_ request: FriendRequest2) {
        withAnimation {
            friendRequests.removeAll { $0.id == request.id }
        }
    }
}

#Preview {
    FriendRequestsMenu()
}
