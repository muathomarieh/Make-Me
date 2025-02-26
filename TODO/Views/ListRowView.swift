//
//  ListRowView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI


struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(Color.accentColor)
            Text(item.title)
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

#Preview {
    
    let item1 = ItemModel(title: "Item1", isCompleted: false)
    
    ListRowView(item: item1)
}
