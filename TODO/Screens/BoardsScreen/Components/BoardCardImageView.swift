//
//  BoardCardImageView.swift
//  TODO
//
//  Created by Muath Omarieh on 11/04/2025.
//

import SwiftUI

struct BoardCardImageView: View {
    let image: String
    var body: some View {
        Image(image)
            .resizable()
            .frame(height: 120)
            .foregroundStyle(.gray)
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.black.opacity(0.3))
            )
    }
}

#Preview {
    BoardCardImageView(image: "testImage")
}
