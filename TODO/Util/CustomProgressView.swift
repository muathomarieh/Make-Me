//
//  CustomProgressView.swift
//  TODO
//
//  Created by Muath Omarieh on 22/02/2025.
//

import SwiftUI

struct CustomProgressBar: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 180, height: 10)
                    .foregroundStyle(.white)
                //.opacity(0.3)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(
                        width: 180 * CGFloat(
                            configuration.fractionCompleted ?? 0.0
                        ),
                        height: 10
                    )
                    .foregroundStyle(Color.clear)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: Color.theme.whiteToAccent),
                            startPoint: .bottomTrailing,
                            endPoint: .topLeading
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .animation(
                        .easeInOut(duration: 0.5),
                        value: configuration.fractionCompleted
                    )
                
            }
            Text(
                "\(Int(CGFloat(configuration.fractionCompleted ?? 0.0) * 100))%"
            )
            .foregroundStyle(Color.appGray)
            .font(.headline)
            .frame(width: 50)
            .animation(.easeInOut(duration: 0.5), value: configuration.fractionCompleted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
