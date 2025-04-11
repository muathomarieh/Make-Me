//
//  BoardCardFavoriteView.swift
//  TODO
//
//  Created by Muath Omarieh on 11/04/2025.
//

import SwiftUI

struct BoardCardFavoriteView: View {
    let isFavorite: Bool
    var body: some View {
        Image(systemName: isFavorite ? "star.fill" : "star")
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(isFavorite ? .yellow : .white)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
            .padding()
    }
}

#Preview {
    BoardCardFavoriteView(isFavorite: true)
}
