//
//  PriorityView.swift
//  TODO
//
//  Created by Muath Omarieh on 03/03/2025.
//

import SwiftUI

struct PriorityView: View {
    
    @Binding var selectedPriority: String?
    
    var body: some View {
        
        VStack {
            Text(Strings.Priority)
            priorityButton(color: Color.priority.Red)
            priorityButton(color: Color.priority.Orange)
            priorityButton(color: Color.priority.Yellow)
            priorityButton(color: Color.priority.Green)
            priorityButton(color: Color.priority.Blue)
            priorityButton(color: Color.priority.Purple)
            priorityButton(color: Color.priority.Gray)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.appGray)
        }
        .shadow(radius: 10)
    }
}

extension PriorityView {
    func priorityButton(color: Color) -> some View {
        Button {
            selectedPriority = color.description
        } label: {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(color)
                .overlay {
                    Circle()
                        .stroke()
                        .opacity(selectedPriority == color.description ? 1 : 0)
                }
        }

    }
}
#Preview {
    ZStack {
        PriorityView(selectedPriority: .constant(Color.red.description))
    }
}
