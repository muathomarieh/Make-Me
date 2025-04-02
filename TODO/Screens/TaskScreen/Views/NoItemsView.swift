//
//  NoItemsView.swift
//  TodoList
//
//  Created by Muath Omarieh on 20/02/2025.
//

import SwiftUI

struct NoItemsView: View {
    
    let inBoard: NewBoard
    @State var animate: Bool = false
    @State var showAddBoardColor: Bool = false
    let maroonColor = Color("MaroonColor")
    
    var body: some View {
      
        VStack(spacing: 10) {
                
            Spacer()
                
            Text("There are no sections!")
                .font(.title)
                .fontWeight(.semibold)
            Text(
                "Are you productive person? I think you should click the add button and add a bunch of tasks to your todo list!"
            )
            .padding(.bottom, 20)
            Button {
                showAddBoardColor.toggle()
            } label: {
                Text("Add Something 🥳")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(
                        animate ? maroonColor : Color.accentColor
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? maroonColor
                    .opacity(0.7) : Color.accentColor
                    .opacity(0.7),
                radius: animate ? 30 : 10,
                x: 0,
                y: animate ? 50 : 30)
            .scaleEffect(animate ? 1.1 : 1.0)
            .offset(y: animate ? -7 : 0)
            
            Spacer()
            Spacer()
                
        }
        .sheet(isPresented: $showAddBoardColor, content: {
            AddSectionView(board: inBoard)
                .padding(.top, 20)
                .presentationDetents([.medium])
        })
        .frame(maxWidth: 400, maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .padding(40)
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever() 
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview {
    NavigationView {
        NoItemsView(inBoard: NewBoard(boardName: "", boardImage: "", creatorId: ""))
            .navigationTitle("Title")
    }
}


