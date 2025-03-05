//
//  AppButton.swift
//  TODO
//
//  Created by Muath Omarieh on 21/02/2025.
//

import SwiftUI

struct AppButton: View {
    let buttonTitle: String
    let buttonClicked: () -> Void
    var body: some View {
        Button {
            buttonClicked()
        } label: {
            Text(buttonTitle.uppercased())
                .foregroundStyle(.white)
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background( LinearGradient(
                    gradient: Gradient(
                        colors: Colors.whiteToAccent
                    ),
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading
                ))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .shadow(radius: 10)
    }
}

#Preview {
    AppButton(buttonTitle: "Save") {
                    
    }
}
