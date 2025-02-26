//
//  ListView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct ListView: View {
    
    @Environment(ListViewModel.self) var listViewModel
    
    var body: some View {
        ZStack {
            
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove { indexSet, destination in
                        listViewModel.moveItem(from: indexSet, to: destination)
                    }
                }
                .listStyle(.automatic)
            }
            
        }
        .navigationTitle("Todo List 📝")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    NavigationLink("Section", destination: AddView())
                    NavigationLink("Item", destination: AddView())
                }
            }
        }
    }
    
   
}

#Preview {
    NavigationView {
        ListView()
    }
    .environment(ListViewModel())
}

