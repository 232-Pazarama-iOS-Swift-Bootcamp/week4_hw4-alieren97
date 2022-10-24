//
//  Photo.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let ownername: String?
    let urlC: String?
    let heightC, widthC: Int?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily, ownername
        case urlC = "url_c"
        case heightC = "height_c"
        case widthC = "width_c"
    }
}
