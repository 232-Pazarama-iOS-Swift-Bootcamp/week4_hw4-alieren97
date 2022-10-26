//
//  SearchViewModel.swift
//  FlickrApp
//
//  Created by Ali Eren on 26.10.2022.
//

import Foundation

enum SearchListChanges {
    case didErrorOccurred(_ error: Error)
    case didFetchPhotos
}


final class SearchViewModel {
    private var photosResponse: PhotoResponse? {
        didSet{
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    var changeHandler: ((SearchListChanges) -> Void)?
    
    var numberOfRows: Int {
        photosResponse?.photos.photo.count ?? .zero
    }
    
    func fetchSearchTagPhotos(tag: String) {
        provider.request(.search(tag: tag)) { result in
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
    
    func fetchPopularPhotos() {
        provider.request(.getPopularPhotos) { result in
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
