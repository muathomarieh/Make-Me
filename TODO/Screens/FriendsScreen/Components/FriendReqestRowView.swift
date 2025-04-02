//
//  FriendReqestRowView.swift
//  TODO
//
//  Created by Muath Omarieh on 30/03/2025.
//

import SwiftUI

struct FriendReqestRowView: View {
    let image: String
    let name: String
    let accepted: () -> Void
    let rejected: () -> Void
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
            VStack {
                HStack {
                    ProfileImageView(image: image)
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(.black)
                    Spacer()
                    Button(action: { accepted() }) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { rejected() }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
        }
        .frame(height: 70)
        .padding()
           
    }
}

#Preview {
    FriendReqestRowView(image: "testImage", name: "Muath Omarieh") {
        
    } rejected: {
        
    }
}
