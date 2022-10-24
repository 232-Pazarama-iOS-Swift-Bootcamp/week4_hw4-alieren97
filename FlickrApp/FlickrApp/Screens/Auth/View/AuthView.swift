//
//  AuthView.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class AuthView: UIView {
    
    
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Sign In","Sign Up"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 5.0
        segment.backgroundColor = UIColor.gray
        segment.tintColor = UIColor.white
        return segment
    }()
    
     lazy var titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Sign In"
         label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Email"
        textField.text = "alierensh3@gmail.com"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Password"
        textField.text = "123456"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(segmentedControl)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmButton)
        
    }
    
    private func setupLayouts() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(100)
            make.trailing.leading.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(50)
            make.height.equalTo(40)
        }
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(100)
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }
}

