//
//  SignUp.swift
//  TODO
//
//  Created by Muath Omarieh on 28/02/2025.
//

import SwiftUI

struct SignUp: View {
    
    @State var emailTextField: String = ""
    @State var passwordTextField: String = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: Colors.accentToWhite), startPoint: .bottomTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                VStack {
                    TextFieldView(placeHolder: "Email...", textFieldText: $emailTextField)
                    TextFieldView(placeHolder: "Password...", textFieldText: $passwordTextField)
                }
                
                AppButton(buttonTitle: "Save".uppercased()) {
                    
                }
                .shadow(color: .white ,radius: 10)
                
                HStack {
                    Text("First time?")
                    Button {
                        
                    } label: {
                        Text("Sign Up")
                            .foregroundStyle(.white)
                    }
                }

            }
            .padding()
            
        }
    }
}

#Preview {
    SignUp()
}
