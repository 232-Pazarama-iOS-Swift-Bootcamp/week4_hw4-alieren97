
//
//  SearchView.swift
//  FlickrApp
//
//  Created by Ali Eren on 26.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class SearchView: UIView {
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.clipsToBounds = false
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.addSubview(searchImageView)
        view.addSubview(searchTextField)
        return view
    }()
    
    lazy var searchTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Search"
        return textField
    }()
        
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        return imageView
    }()
    
    lazy var doneButton: UIButton = {
       let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          layout.minimumLineSpacing = 2
          layout.scrollDirection = .vertical
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.register(LikesAndSavedCollectionViewCell.self, forCellWithReuseIdentifier: LikesAndSavedCollectionViewCell.identifier)
          cv.showsHorizontalScrollIndicator = false
          cv.translatesAutoresizingMaskIntoConstraints = false
          return cv
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
        addSubview(searchView)
        addSubview(doneButton)
        addSubview(collectionView)
    }
    
    private func setupLayouts() {
        
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 2 + 80)
            make.height.equalTo(70)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchImageView.snp.trailing).offset(20)
            make.top.bottom.equalToSuperview().inset(20)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.equalTo(searchView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

