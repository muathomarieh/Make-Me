//
//  BoardView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct BoardCardView: View {
    
    let boardName: String
    let imageName: String
    let isFavorite: Bool
    
    let onClick: () -> Void
    
    var body: some View {
        ZStack {
         
            Image(imageName)
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
            
            Text(boardName)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topLeading)
                .padding()
            
            Image(systemName: isFavorite ? "star.fill" : "star")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(isFavorite ? .yellow : .white)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .bottomTrailing)
                .padding()
                .onTapGesture {
                    onClick()
                }
            
            Image(systemName: "plus")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .topTrailing)
                .padding()
            
            ScrollView(.horizontal, content: {
                
                HStack {
                    ForEach(0..<30) { _ in
                        Circle()
                            .frame(width: 25, height: 25)
                    }
                }
            })
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(width: 150)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomLeading)
            .padding()
            
            
        }
    }
}

#Preview {
    BoardCardView(boardName: "TEST_BOARD_NAME", imageName: "testImage", isFavorite: true) {
        
    }
}
