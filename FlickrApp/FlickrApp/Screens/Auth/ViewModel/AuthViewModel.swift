//
//  AuthViewModel.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AuthViewModelChange {
    case didErrorOccurred(_ error: Error)
    case didSignUpSuccessful
}

final class AuthViewModel {
    
    var changeHandler: ((AuthViewModelChange) -> Void)?
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
            guard let userId = authResult?.user.uid else { return }
            Firestore.firestore().collection("users").document(userId).setData(["uid":userId,"email":email])
            self.changeHandler?(.didSignUpSuccessful)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.changeHandler?(.didErrorOccurred(error))
                return
            }
           
            completion()
        }
    }
    
}
