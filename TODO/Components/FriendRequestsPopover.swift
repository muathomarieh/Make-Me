////
////  FriendRequestsPopover.swift
////  TODO
////
////  Created by Muath Omarieh on 29/03/2025.
////
//import SwiftUI
//
//struct FriendRequestsPopover: View {
//    @State private var friendRequests = [
//        FriendRequest(id: "1", name: "Ahmed"),
//        FriendRequest(id: "2", name: "Fatima"),
//        FriendRequest(id: "3", name: "Omar")
//    ]
//    
//    @State private var showPopover = false
//
//    var body: some View {
//        Button(action: { showPopover.toggle() }) {
//            Image(systemName: "person.badge.plus")
//                .resizable()
//                .frame(width: 30, height: 30)
//        }
//        .popover(isPresented: $showPopover) {
//            VStack {
//                Text("Friend Requests")
//                    .font(.headline)
//                    .padding()
//                
//                if friendRequests.isEmpty {
//                    Text("No new requests").padding()
//                } else {
//                    List(friendRequests) { request in
//                        HStack {
//                            Text(request.name)
//                            Spacer()
//                            Button(action: { acceptRequest(request) }) {
//                                Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
//                            }
//                            Button(action: { declineRequest(request) }) {
//                                Image(systemName: "xmark.circle.fill").foregroundColor(.red)
//                            }
//                        }
//                    }
//                    .frame(height: 200) // Adjust popover size
//                }
//            }
//            .padding()
//        }
//    }
//
//    private func acceptRequest(_ request: FriendRequest) {
//        friendRequests.removeAll { $0.id == request.id }
//        print("\(request.name) accepted!")
//    }
//
//    private func declineRequest(_ request: FriendRequest) {
//        friendRequests.removeAll { $0.id == request.id }
//        print("\(request.name) declined!")
//    }
//}
//
//
//#Preview {
//    FriendRequestsPopover()
//}
