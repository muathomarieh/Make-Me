//
//  FriendsView.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: Colors.accentToWhite),
                startPoint: .bottomTrailing,
                endPoint: .topLeading
            ).ignoresSafeArea()
            
            VStack {
                TopBarView(
                    barType: .friends,
                    title: "Friends",
                    image: "testImage"
                )
                VStack {
                    List {
                        ForEach(0..<10) { index in
                            FriendRowView(image: "testImage", name: "Muath Omarieh")
                                .listRowBackground(Color.clear)
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
                    print("Add friend button clicked")
                }
            }
        }
    }
}

#Preview {
    FriendsView()
}
