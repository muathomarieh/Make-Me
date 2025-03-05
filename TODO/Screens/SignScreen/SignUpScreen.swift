//
//  LoginScreen.swift
//  TODO
//
//  Created by Muath Omarieh on 28/02/2025.
//

import SwiftUI

struct LoginScreen: View {
    
    
    @State var nameTextField: String = ""
    @State var emailTextField: String = ""
    @State var passwordTextField: String = ""
    
    @State var showSheet: Bool = false
    @State var selectedProfileImageIndex: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: Colors.accentToWhite), startPoint: .bottomTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                ZStack {
                    Image("testImage")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .foregroundStyle(.white)
                        }
                    Image(systemName: "plus")
                        .font(.title)
                        .padding(4)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 190 ,height: 170 ,alignment: .bottomTrailing)
                        .background(.clear)
                }
                .onTapGesture {
                    showSheet.toggle()
                }
                
                VStack {
                    TextFieldView(placeHolder: "Name...", textFieldText: $nameTextField)
                    TextFieldView(placeHolder: "Email...", textFieldText: $emailTextField)
                    TextFieldView(placeHolder: "Password...", textFieldText: $passwordTextField)
                }
                
                AppButton(buttonTitle: "Save".uppercased()) {
                    
                }
                .shadow(color: .white ,radius: 10)
                
                HStack {
                    Text("Have an account?")
                    Button {
                        
                    } label: {
                        Text("SignIn")
                            .foregroundStyle(.white)
                    }
                }

            }
            .padding()
            
        }
        .sheet(isPresented: $showSheet) {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<50) { index in
                        Image("testImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(.circle)
                            .overlay {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .foregroundStyle(
                                        selectedProfileImageIndex == index ? Color.accentColor : .white)
                            }
                            .onTapGesture {
                                selectedProfileImageIndex = index
                                showSheet.toggle()
                            }
                            .padding()
                    }
                }
            }
            .presentationDetents([.height(150)])
        }
    }
}

#Preview {
    LoginScreen()
}
