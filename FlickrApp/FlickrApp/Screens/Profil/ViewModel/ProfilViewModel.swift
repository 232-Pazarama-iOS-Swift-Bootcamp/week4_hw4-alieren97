//
//  ProfilViewModel.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class ProfilViewModel {
    
    var listPhotos:[Any] = []
    
    private let db = Firestore.firestore()
    
    var numberOfRows: Int {
        listPhotos.count
    }
        
    func fetchPhotosForProfile(with collectionName: String) {
        guard let currentUser = Auth.auth().currentUser else {return}
        db.collection("users").document(currentUser.uid).addSnapshotListener { snapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            if let data = snapshot?.data() {
                self.listPhotos = data[collectionName]! as! [Any]
            }
        }
    }
}
