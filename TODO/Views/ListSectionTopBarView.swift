//
//  ListSectionTopBarView.swift
//  TODO
//
//  Created by Muath Omarieh on 28/02/2025.
//

import SwiftUI

struct ListSectionTopBarView: View {
    
    let title: String
    let topBarType: ListSectionTopBarType
    let editClicked: () -> Void
    let xmarkClicked: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: topBarType == .task ? 90 : 120)
                .foregroundStyle(.white)
            HStack {
                if topBarType == .listSection {
                    Button {
                        editClicked()
                    } label: {
                        Image(systemName: "pencil")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(Color.accentColor)
                    }
                    Spacer()
                }
                Text(title)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(Color.accentColor)
                Spacer()
                Button {
                    xmarkClicked()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(Color.accentColor)
                }
            }
            .offset(y: topBarType == .task ? 5 : 10)
            .padding(.top, topBarType == .task ? 0 : 20)
            .padding(.horizontal, 20)
        }
    }
}

enum ListSectionTopBarType {
    case listSection
    case task
}

#Preview {
    ListSectionTopBarView(title: "BoardTest", topBarType: .task
    ) {
        
    } xmarkClicked: {
        
    }

}
