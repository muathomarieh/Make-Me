//
//  CircularButton.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import SwiftUI

struct CircularButton: View {
    
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: Colors.whiteToAccent), startPoint: .bottomTrailing, endPoint: .topLeading)
                )
                .frame(width: 60, height: 60)
                .overlay {
                    Image(systemName: icon)
                        .foregroundStyle(.white)
                }
        }

    }
}

#Preview {
    CircularButton(icon: "play.fill") {
        
    }
}
