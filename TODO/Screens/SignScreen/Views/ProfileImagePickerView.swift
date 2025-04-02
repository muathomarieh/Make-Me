//
//  ProfileImagePickerView.swift
//  TODO
//
//  Created by Muath Omarieh on 31/03/2025.
//

import SwiftUI

struct ProfileImagePickerView: View {
    
    @Binding var selectedProfileImage: Int
    @Binding var showSheet: Bool
    let profileImagePickerViewType: profileImagePickerViewType
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<50) { index in
                    Image("testImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(
                                    selectedProfileImage == index ? Color.accentColor : .white)
                        }
                        .onTapGesture {
                            selectedProfileImage = index
                            showSheet.toggle()
                            if profileImagePickerViewType == .updating {
                                FirebaseFirestore.shared.updateUserProfileImage(image: "testImage")//use image name
                            }
                        }
                        .padding()
                }
            }
        }
        .presentationDetents([.height(150)])
    }
}

enum profileImagePickerViewType {
    case updating
    case signing
}
#Preview {
    ProfileImagePickerView(selectedProfileImage: .constant(1), showSheet: .constant(false), profileImagePickerViewType: .signing)
}
