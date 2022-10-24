//
//  FeedListTableViewCell.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit
import SnapKit

final class FeedListTableViewCell :UITableViewCell {
    static let identifier = "FeedListTableViewCell"
    
    private lazy var usernameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    var feedImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var heartButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
   
    private lazy var saveButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(feedImageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(saveButton)
        
    }
    
    private func setupLayout() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        feedImageView.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(20)
            
            make.height.equalTo(300)
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(feedImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(feedImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            
            make.width.height.equalTo(40)
        }
    }
}

extension FeedListTableViewCell {
    func configureCell(photo:Photo) {
        usernameLabel.text = photo.owner
        
        
    }
}
