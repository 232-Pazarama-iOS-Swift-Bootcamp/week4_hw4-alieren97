//
//  AuthViewController.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit


final class AuthViewController: UIViewController {
    
    let authView = AuthView()
    private let viewModel: AuthViewModel
    
    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            authView.titleLabel.text = authType.rawValue
            authView.confirmButton.setTitle(authType.rawValue, for: .normal)
        }
    }
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authView
        authView.backgroundColor = .white
        authView.segmentedControl.addTarget(self, action: #selector(segmentChange), for: .valueChanged)
        authView.confirmButton.addTarget(self, action: #selector(confirmButtonDidTapped), for: .touchUpInside)
    }
    
    
    @objc private func segmentChange(_ sender: UISegmentedControl) {
        let title = authView.segmentedControl.titleForSegment(at: authView.segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: title ?? "Sign In")
    }
    
    @objc private func confirmButtonDidTapped() {
        guard let credential = authView.emailTextField.text,
              let password = authView.passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                let searchViewController = SearchViewController()
                let feedViewModel = FeedListViewModel()
                let feedViewController = FeedListViewController(viewModel: feedViewModel)
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [feedViewController, searchViewController]
                self.navigationController?.pushViewController(tabBarController, animated: true)
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
    }
}
