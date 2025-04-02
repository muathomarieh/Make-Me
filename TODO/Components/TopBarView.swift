//
//  TopBarView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var showSignScreen: Bool
    @Binding var showFriendRequests: Bool
    var badgeValue: Int
    let barType: TopBarType
    let title: String
    let image: String
    
    @State var selectedProfileImage: Int = 0
    @State var showProfileImageSheet: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 120)
                .foregroundStyle(.white)
            HStack {
                if barType == .boards {
                    Text(title)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(Color.accentColor)
                }
                
                if barType == .friends {
                        Image(systemName: "text.justify")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                showFriendRequests.toggle()
                            }
                            .overlay {
                                NotificationCountView(value: badgeValue)
                            }
                        
                }
                Spacer()
                if barType == .friends {
                    Menu {
                        Button("LogOut") {
                            do {
                                try AuthenticationManager.shared.signOut()
                                showSignScreen = true
                            } catch {
                                print(error)
                            }
                        }
                        Button("Change profile image.") {
                            showProfileImageSheet.toggle()
                        }
                    } label: {
                        ProfileImageView(image: image)
                    }
                } else {
                    ProfileImageView(image: image)
                }
            }
            .sheet(isPresented: $showProfileImageSheet) {
                ProfileImagePickerView(selectedProfileImage: $selectedProfileImage, showSheet: $showProfileImageSheet, profileImagePickerViewType: .updating)
            }
            .padding(.top, 30)
            .padding(.horizontal, 20)
        }
        
    }
}

enum TopBarType {
    case boards
    case friends
}

#Preview {
    TopBarView(showSignScreen: .constant(false), showFriendRequests: .constant(false), badgeValue: 0, barType: .friends, title: "Boards", image: "testImage")
        .background(.red)
}
