//
//  MainTabBarController.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    func configureViewControllers() {
        let feedViewModel = FeedListViewModel()
        let feed = FeedListViewController(viewModel: feedViewModel)
        let nav1 = templateNavigationController(image:  UIImage(systemName: "magnifyingglass")!, title: "Kesfedin", rootViewController: feed)
        
        let searchViewModel = SearchViewModel()
        let explore = SearchViewController(viewModel: searchViewModel)
        let nav2 = templateNavigationController(image:  UIImage(systemName: "heart")!, title: "Favoriler", rootViewController: explore)
        
        let profilViewModel = ProfilViewModel()
        let notifications = ProfilViewController(viewModel: profilViewModel)
        let nav3 = templateNavigationController(image:  UIImage(systemName: "drop.triangle")!, title: "Seyahatlar", rootViewController: notifications)
        
      
        viewControllers = [nav1,nav2,nav3]
    }
    
    func templateNavigationController(image: UIImage,title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
