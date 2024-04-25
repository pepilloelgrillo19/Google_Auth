//
//  AuthViewModel.swift
//  SwiftUIForm
//
//  Created by Luis on 25/4/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener {
            [weak self] _, user in
            guard let self = self else {
                return
            }
            self.user = user
    }
  }
// function to sign-in
    func signIn(emailAddress: String, password: String ){
        Auth.auth().signIn(withEmail: emailAddress, password: password){ result, error in
            if let error = error {
                print("an error occurred: \(error.localizedDescription)")
                return
            }
        }
    }
// function to create an account
    func signUp(emailAddress: String, password: String ){
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result,
            error in
            if let error = error {
                print("an error occurred: \(error.localizedDescription)")
                return
            }
        }
    }
// function to logout
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError { print("Error signing out: %@", signOutError)
        }
    }
// function to reset password
    func resetPassword(emailAddress: String) {
            Auth.auth().sendPasswordReset(withEmail: emailAddress)
        }
}
