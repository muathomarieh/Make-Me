//
//  ProfileImageView.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import SwiftUI

struct ProfileImageView: View {
    let image: String
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(.circle)
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 2))
                    .foregroundStyle(Color.accentColor)
            }
    }
}

#Preview {
    ProfileImageView(image: "testImage")
}
