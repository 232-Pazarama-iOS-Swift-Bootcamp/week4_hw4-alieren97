//
//  ProfilView.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class ProfilView: UIView {
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.tintColor = .black
        return button
    }()
    
    
    private lazy var profilImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .black
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "Ali Eren"
        return label
    }()
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = [UIImage(systemName: "heart"),UIImage(systemName: "square.and.arrow.down")]
        let segment = UISegmentedControl(items: items as [Any])
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 5.0
        segment.backgroundColor = UIColor.systemGray5
        segment.tintColor = UIColor.white
        return segment
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
        addSubview(profilImageView)
        addSubview(usernameLabel)
        addSubview(segmentedControl)
        addSubview(collectionView)
    }
    
    private func setupLayouts() {
        profilImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(50)
            make.width.height.equalTo(100)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(130)
            make.leading.equalTo(profilImageView.snp.trailing).offset(30)
            make.height.equalTo(50)
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

