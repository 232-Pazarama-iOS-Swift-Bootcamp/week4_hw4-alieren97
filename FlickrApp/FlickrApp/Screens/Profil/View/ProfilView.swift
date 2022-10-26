//
//  ProfilView.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import UIKit

final class ProfilView: UIView {
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "ali"
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
        addSubview(usernameLabel)
        addSubview(segmentedControl)
        addSubview(collectionView)
    }
    
    private func setupLayouts() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(50)
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

