//
//  CircleAddButton.swift
//  TODO
//
//  Created by Muath Omarieh on 26/02/2025.
//

import SwiftUI

struct CircleAddButton: View {
    let onCLick: () -> Void
    var body: some View {
        VStack {
            Spacer()
            Button {
                withAnimation {
                    onCLick()
                }
            } label: {
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundStyle(.white)
                    .padding()
                    .shadow(radius: 2)
                    .clipShape(Circle())
                    .overlay {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
            }

        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
    }
}

#Preview {
    CircleAddButton() {
        
    }
}
