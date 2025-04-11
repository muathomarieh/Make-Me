//
//  BoardCardNameView.swift
//  TODO
//
//  Created by Muath Omarieh on 11/04/2025.
//

import SwiftUI

struct BoardCardNameView: View {
    let boardName: String
    var body: some View {
        Text(boardName)
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .topLeading)
            .padding()
    }
}

#Preview {
    BoardCardNameView(boardName: "BoardName")
}
