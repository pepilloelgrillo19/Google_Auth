//
//  SignUpView.swift
//  SwiftUIForm
//
//  Created by Luis on 25/4/24.
//

import SwiftUI
//Esta será la vista de registro de usuarios
struct SignUpView: View {
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    //Variable para que se muestre el
    
    @State private var showingSheet:Bool = false
    
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Email", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                }
                Section {
                    Button(action: {
                        // Sign Up to Firebase
                        authModel.signUp(emailAddress: emailAddress,
                                                       password: password)
                    }) {
                        Text("Sign Up").bold()
                    }
                }
                Section(header: Text("If you already have an account:")) {
                    Button(action: {
                        // Sign In to Firebase
                        authModel.signIn(emailAddress: emailAddress,
                                           password: password)
                    }) {
                        Text("Sign In")
                    }
                }
                Section(header: Text("Autenticación con Google")) {
                    Button(action: {
                        
                        authModel.signInWithGoogle()
                    }) {
                        HStack{
                            Image("googlelogo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            Text("Google")
                        }
                    }
                }
                
            }.navigationTitle("Welcome")
                .toolbar {
                    ToolbarItemGroup(placement:
                            .cancellationAction) {
                                Button {
                                    showingSheet.toggle()
                                    
                                } label: {
                                    Text("Forgot password?")
                                }
                                .sheet(isPresented: $showingSheet) {
                                    ForgotPasswordView()
                                }
                            }
                }
        }
    }
    
    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
    }
}
