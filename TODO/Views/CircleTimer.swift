//
//  CircleTimer.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import SwiftUI

struct CircleTimer: View {
    
    let fraction: Double
    let primaryText: String
    let secondaryText: String
    
    var body: some View {
        ZStack {
            // background circle
            Circle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: Color.theme.accentToWhite), startPoint: .bottomTrailing, endPoint: .topLeading)
                )
            // timer circle
            Circle()
                .trim(from: 0, to: fraction)
                .stroke(.white, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .opacity(0.7)
                .rotationEffect(Angle(degrees: -90))
                .padding()
                .animation(.easeInOut, value: fraction)
            // primary text
            Text(primaryText)
                .foregroundStyle(.white)
                .font(.system(size: 50, weight: .semibold, design: .rounded))
            // secondary text
            Text(secondaryText)
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundStyle(.white)
                .offset(y: 50)
        }
        .padding()
    }
}

#Preview {
    CircleTimer(fraction: 0.5, primaryText: "12:23", secondaryText: "Working")
}
