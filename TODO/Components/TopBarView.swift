//
//  TopBarView.swift
//  TODO
//
//  Created by Muath Omarieh on 27/02/2025.
//

import SwiftUI

struct TopBarView: View {
    
    let barType: TopBarType
    let title: String
    let image: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 120)
                .foregroundStyle(.white)
            HStack {
                if barType == .boards {
                    Text(title)
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(Color.accentColor)
                }
                
                if barType == .friends {
                    Menu {
                        Button("Open in Preview") {
                            
                        }
                    } label: {
                        Image(systemName: "text.justify")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
//                    Image(systemName: "text.justify")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                        .onTapGesture {
//                            Menu
//                        }
                }
                Spacer()
                ProfileImageView(image: image)
            }
            //.padding()
            .padding(.top, 30)
            .padding(.horizontal, 20)
        }
        
    }
}

enum TopBarType {
    case boards
    case friends
}

#Preview {
    TopBarView(barType: .friends, title: "Boards", image: "testImage")
        .background(.red)
}
