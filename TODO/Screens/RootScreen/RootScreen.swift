//
//  RootScreen.swift
//  TODO
//
//  Created by Muath Omarieh on 24/03/2025.
//

import SwiftUI

struct RootScreen: View {
    
    @StateObject var listViewModel: AppViewModel = AppViewModel()
    @State var showSignScreen: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignScreen {
                NavigationStack {
                    MainView(showSignScreen: $showSignScreen)
                }
                .environmentObject(listViewModel)
            }
        }
        .onAppear {
            do {
                let authUserID = try AuthenticationManager.shared.getAuthenticatedUser()
                print(showSignScreen)
            } catch {
                showSignScreen = true
                print(error)
            }
        }
        .fullScreenCover(isPresented: $showSignScreen) {
            NavigationStack {
                SignScreen(showSignScreen: $showSignScreen)
            }
        }
        
    }
}

#Preview {
    RootScreen()
}
