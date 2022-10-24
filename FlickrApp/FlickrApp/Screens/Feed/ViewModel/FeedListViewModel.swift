//
//  FeedViewModel.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import Moya

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
    
    func coinForIndexPath(_ indexPath: IndexPath) -> Photo? {
        photosResponse?.photos.photo[indexPath.row]
    }
    
}
