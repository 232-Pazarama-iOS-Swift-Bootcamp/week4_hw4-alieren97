//
//  AppDelegate.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        _ = Firestore.firestore()
        setupWindow()
        
        return true
    }
    
    private func setupWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = AuthViewModel()
        let viewController = AuthViewController(viewModel: viewModel)
//        let searchViewModel = SearchViewModel()
//        let searchController = SearchViewController(viewModel: searchViewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}


