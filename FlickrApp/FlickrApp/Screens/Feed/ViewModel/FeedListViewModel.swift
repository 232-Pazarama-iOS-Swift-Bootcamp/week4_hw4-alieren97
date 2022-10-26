//
//  FeedViewModel.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import Moya
import FirebaseFirestore
import FirebaseAuth

enum FeedListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchPhotos
}

final class FeedListViewModel {
    private var photosResponse: PhotoResponse? {
        didSet{
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    var changeHandler: ((FeedListChanges) -> Void)?
    
    var numberOfRows: Int {
        photosResponse?.photos.photo.count ?? .zero
    }
    
    func fetchPhotos() {
        provider.request(.getRecentPhotos) { result in
            switch result {
            case .failure(let error):
                self.changeHandler?(.didErrorOccurred(error))
            case .success(let response):
                do {
                  
                    let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: response.data)
                    self.photosResponse = photoResponse
                    
                } catch {
                    self.changeHandler?(.didErrorOccurred(error))
                }
            }
        }
    }
    
    func addFavorites(with photo: Photo) {
        guard let currentUser = Auth.auth().currentUser else {return}
        let userReference = Firestore.firestore().collection("users").document(currentUser.uid)
        userReference.updateData(["likes":FieldValue.arrayUnion([photo.urlC])])
    }
    
    func removeFavorites(with photo: Photo) {
        guard let currentUser = Auth.auth().currentUser else {return}
        let userReference = Firestore.firestore().collection("users").document(currentUser.uid)
        userReference.updateData(["likes":FieldValue.arrayRemove([photo.urlC])])
    }
    
    func addSaved(with photo:Photo) {
        guard let currentUser = Auth.auth().currentUser else {return}
        let userReference = Firestore.firestore().collection("users").document(currentUser.uid)
        userReference.updateData(["saved":FieldValue.arrayUnion([photo.urlC])])
    }
    
    func removeSaved(with photo: Photo) {
        guard let currentUser = Auth.auth().currentUser else {return}
        let userReference = Firestore.firestore().collection("users").document(currentUser.uid)
        userReference.updateData(["saved":FieldValue.arrayRemove([photo.urlC])])
    }
  
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photosResponse?.photos.photo[indexPath.row]
    }
    
}
