//
//  BoardInviteRow.swift
//  TODO
//
//  Created by Muath Omarieh on 30/03/2025.
//

import SwiftUI

struct BoardInviteRow: View {
    let image: String
    let name: String
    let boardName: String
    let accepted: () -> Void
    let rejected: () -> Void
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
            VStack {
                HStack {
                    Text(name+" invites you to join board with name "+boardName)
                        .font(.headline)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.trailing)
                    Spacer()
                    Button(action: { accepted() }) {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { rejected() }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding()
        }
        .padding()
           
    }
}

#Preview {
    BoardInviteRow(image: "testImage", name: "Muath Omarieh", boardName: "Math") {
        
    } rejected: {
        
    }

}
