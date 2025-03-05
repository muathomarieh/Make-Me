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
            priorityButton(colorName: Strings.Red)
            priorityButton(colorName: Strings.Orange)
            priorityButton(colorName: Strings.Yellow)
            priorityButton(colorName: Strings.Green)
            priorityButton(colorName: Strings.Blue)
            priorityButton(colorName: Strings.Purple)
            priorityButton(colorName: Strings.Gray)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.appGray)
        }
    }
}

extension PriorityView {
    func priorityButton(colorName: String) -> some View {
        Button {
            selectedPriority = colorName
        } label: {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color(colorName))
                .overlay {
                    Circle()
                        .stroke()
                        .opacity(selectedPriority == colorName ? 1 : 0)
                }
        }

    }
}
#Preview {
    @Previewable
    @State var priority: String? = nil

    ZStack {
        Color.black
        PriorityView(selectedPriority: $priority)
    }
}
