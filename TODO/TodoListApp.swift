//
//  TodoListApp.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - data point
 View - UI
 ViewNodel - manages Models for View
 */

@main
struct TodoListApp: App {
    
    @State var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationStack {
                MainView()
            }
            .environment(listViewModel)
        }
    }
}
