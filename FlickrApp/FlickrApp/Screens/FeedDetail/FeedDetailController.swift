//
//  FeedDetailController.swift
//  FlickrApp
//
//  Created by Ali Eren on 26.10.2022.
//

import Foundation
import UIKit

final class FeedDetailController: UIViewController {
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
