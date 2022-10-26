//
//  LikesAndSavedCollectionViewCell.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class LikesAndSavedCollectionViewCell: UICollectionViewCell {
    static let identifier = "LikesAndSavedCollectionViewCell"
    
    lazy var photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
    }
    
    private func setupLayout() {
        photoImageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    
}
