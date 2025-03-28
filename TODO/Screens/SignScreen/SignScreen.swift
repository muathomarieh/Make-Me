//
//  LoginScreen.swift
//  TODO
//
//  Created by Muath Omarieh on 28/02/2025.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignScreen: View {
    
    @StateObject private var signViewModel = SignViewModel()
    
    @State var nameTextField: String = ""
    
    @State var showSheet: Bool = false
    @State var selectedProfileImageIndex: Int = 0
    @State var showSignUp: Bool = true
    
    @Binding var showSignScreen: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: Color.theme.accentToWhite), startPoint: .bottomTrailing, endPoint: .topLeading)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                if showSignUp {
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
                }
                
                VStack {
                    if showSignUp {
                        TextFieldView(placeHolder: "Name...", textFieldText: $signViewModel.name)
                    }
                    TextFieldView(placeHolder: "Email...", textFieldText: $signViewModel.email)
                    TextFieldView(placeHolder: "Password...", textFieldText: $signViewModel.password)
                }
                
                AppButton(buttonTitle: showSignUp ? "SignUp" : "SignIn") {
                    Task {
                        if showSignUp {
                            do {
                                try await signViewModel.signUp()
                                showSignScreen = false
                            } catch {
                                print(error)
                            }
                        } else {
                            do {
                                try await signViewModel.signIn()
                                showSignScreen = false
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                .shadow(color: .white ,radius: 10)
                
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide,state: .normal)) {
                    Task {
                        do {
                            try await signViewModel.signInGoogle()
                            showSignScreen = false
                        } catch {
                            print(error)
                        }
                    }
                }
                
                HStack {
                    Text( showSignUp ? "Have an account?" : "First time?")
                    Button {
                        withAnimation(.easeInOut) {
                            showSignUp.toggle()
                        }
                    } label: {
                        Text( showSignUp ? "SignIn" : "SignUp")
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
    SignScreen(showSignScreen: .constant(true))
}
