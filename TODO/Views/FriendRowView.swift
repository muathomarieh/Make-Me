//
//  FriendRowView.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import SwiftUI

struct FriendRowView: View {
    
    let image: String
    let name: String
    
    var body: some View {
        
        HStack {
            ProfileImageView(image: image)
            Text(name)
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
            Image(systemName: "plus")
                .foregroundStyle(.white)
        }
        .frame(height: 70)
           
    }
}

#Preview {
    FriendRowView(image: "testImage", name: "Muath Omarieh")
}
