//
//  MainView.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import SwiftUI

struct MainView: View {
    
    @Environment(ListViewModel.self) var listViewModel
    init() {
        let appearance = UITabBarAppearance()
        
        appearance.backgroundColor = UIColor(
            #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        )

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(
            #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        )
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(
            #colorLiteral(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 1
            )
        )]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar
            .appearance().tintColor = UIColor(
                #colorLiteral(red: 0.9, green: 0.2, blue: 0.2, alpha: 1)
            )  
        UITabBar
            .appearance().unselectedItemTintColor = UIColor(
                #colorLiteral(
                    red: 0.921431005,
                    green: 0.9214526415,
                    blue: 0.9214410186,
                    alpha: 1
                )
            )
    }


    var body: some View {
        ZStack {
            
            TabView {
                Tab("Pomodoro", systemImage: "clock") {
                    withAnimation {
                        
                        PomodoroView()
                            .transition(
                                AnyTransition.opacity.animation(.easeIn)
                            )
                        
                    }
                }

                Tab("Friends", systemImage: "person") {
                    FriendsView()
                }

                Tab("Boards", systemImage: "checklist") {
                    withAnimation {
                        BoardsView()
                            .transition(
                                AnyTransition.opacity.animation(.easeIn)
                            )
                    }
                }
                
            }
        }
    }
}

#Preview {
    MainView()
        .environment(ListViewModel())
}
