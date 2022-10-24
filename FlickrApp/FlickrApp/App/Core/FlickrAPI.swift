//
//  FlickrAPI.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import Moya


let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let provider = MoyaProvider<FlickrAPI>(plugins: [plugin])



enum FlickrAPI {
    case getRecentPhotos
}

extension FlickrAPI: TargetType{
    var baseURL: URL {
        guard let url = URL(string: "https://www.flickr.com/services/rest") else {
            fatalError("Base URL not found or not in correct format.")
        }
        return url
    }
    
    var path: String {
        "/"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        let parameters: [String : Any] = ["method" : "flickr.photos.getRecent",
                                          "format" : "json",
                                          "nojsoncallback" : 1,
                                          "api_key" : "fa09e0f3cf3160263024534bfa7094e2",
                                          "extras" : "url_c"]
        
        return .requestParameters(parameters:  parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
