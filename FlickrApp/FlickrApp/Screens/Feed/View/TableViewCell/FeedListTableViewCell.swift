//
//  FeedListTableViewCell.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit
import SnapKit

protocol FeedListTableViewCellDelegate: AnyObject{
    func feedListTableViewCellFavButton(_ cell: FeedListTableViewCell, didTapAddFavoriteButton button: UIButton)
    func feedListTableViewCellSaveButton(_ cell: FeedListTableViewCell, didTapSaveButton button: UIButton)
}

final class FeedListTableViewCell :UITableViewCell {
    static let identifier = "FeedListTableViewCell"
    
    weak var delegate: FeedListTableViewCellDelegate?
    var photo: Photo?
    
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
        label.textColor = .black
        return label
    }()
    
    var feedImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var heartButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(didTapAddFavoriteButton(_:)), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        return button
    }()
   
    lazy var saveButton: UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapSaveButton(_:)), for: .touchUpInside)
        
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
        contentView.addSubview(profilImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(feedImageView)
        contentView.addSubview(heartButton)
        contentView.addSubview(saveButton)
        
    }
    
    private func setupLayout() {
        
        profilImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(20)
            make.height.width.equalTo(40)
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalTo(profilImageView.snp.trailing).offset(20)
            make.height.equalTo(20)
        }
        
        feedImageView.snp.makeConstraints { make in
            make.top.equalTo(profilImageView.snp.bottom).offset(20)
            make.height.equalTo(350)
            make.width.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(feedImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(feedImageView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(50)
        }
    }

}

extension FeedListTableViewCell {
    func configureCell(photo:Photo) {
        self.photo = photo
        usernameLabel.text = photo.owner
    }
    
    @objc
    private func didTapAddFavoriteButton(_ sender: UIButton) {
        delegate?.feedListTableViewCellFavButton(self, didTapAddFavoriteButton: sender)
    }
    
    @objc private func didTapSaveButton(_ sender: UIButton) {
        delegate?.feedListTableViewCellSaveButton(self, didTapSaveButton: sender)
    }
}
