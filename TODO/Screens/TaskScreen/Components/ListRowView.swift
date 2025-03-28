//
//  ListRowView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI


struct ListRowView: View {
    
    let item: TaskModel
    let checkmarkClicked: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(Color.accentColor)
                .onTapGesture {
                    checkmarkClicked()
                }
            Text(item.title)
            
            Spacer()
            
            if let startingTime = item.startingTime {
                RoundedRectangle(cornerRadius: 6)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 60, height: 35)
                    .overlay {
                        HStack {
                            Text(startingTime.formattedTime)
                                .font(.caption)
                                .foregroundStyle(.white)
                        }
                    }
            }
            Image(systemName: "chevron.forward")
                .padding(.trailing)
            
        }
        .font(.title2)
        .padding(.vertical, item.startingTime == nil ? 6 : 2)
    }
}

#Preview {
    let item1 = TaskModel(title: "Item4", description: "desc4", startingTime: Date(),isCompleted: false, remindMe: false, priority: Strings.Blue)
   
    ZStack {
        Color.blue
        ListRowView(item: item1, checkmarkClicked: {
            
        })
    }
   
}
