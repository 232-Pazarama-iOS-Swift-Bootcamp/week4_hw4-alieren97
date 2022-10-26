//
//  FeedController.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit
import Kingfisher

final class FeedListViewController: UIViewController {
    
    private var viewModel: FeedListViewModel
    private let feedListView = FeedListView()

    
    private var tableViewCell: FeedListTableViewCell = {
        let view = FeedListTableViewCell()
//        view.delegate = self
        return view
    }()
    
    init(viewModel: FeedListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = feedListView
        feedListView.backgroundColor = .gray
        title = "Feed"
        configureTableView()
        viewModel.fetchPhotos()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.feedListView.feedListTableView.reloadData()
            case .didErrorOccurred(let error):
               print(error
               )
            }
        }
        
    }
}

// MARK: - UITableViewDelegate
extension FeedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = viewModel.coinForIndexPath(indexPath) else {
            return
        }
//        let viewController = FeedDetailController(photo: photo)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FeedListViewController:UITableViewDataSource {
    func configureTableView() {
        feedListView.feedListTableView.delegate = self
        feedListView.feedListTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRows)
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedListTableViewCell.identifier, for: indexPath) as! FeedListTableViewCell
        guard let photo = viewModel.coinForIndexPath(indexPath) else {
            fatalError("coin not found.")
        }
        var imgurl = URL(string: photo.urlC ?? "")
        cell.delegate = self
        cell.feedImageView.kf.setImage(with: imgurl)
        cell.configureCell(photo: photo)
        
        return cell
    }
}


extension FeedListViewController: FeedListTableViewCellDelegate{
    
    func feedListTableViewCellSaveButton(_ cell: FeedListTableViewCell, didTapSaveButton button: UIButton) {
        guard let photo = cell.photo else { return }
        if button.image(for: .normal) == UIImage(systemName: "square.and.arrow.down") {
            cell.saveButton.setImage(UIImage(systemName: "square.and.arrow.down.fill"), for: .normal)
            cell.saveButton.tintColor = .red
            viewModel.addSaved(with: photo)
            
        } else {
            cell.saveButton.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
            cell.saveButton.tintColor = .black
            viewModel.removeSaved(with: photo)
        }
    }
    

    func feedListTableViewCellFavButton(_ cell: FeedListTableViewCell, didTapAddFavoriteButton button: UIButton) {
        guard let photo = cell.photo else {return}
        
        if button.image(for: .normal) == UIImage(systemName: "heart") {
            cell.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.heartButton.tintColor = .red
            viewModel.addFavorites(with: photo)
            
        } else {
            cell.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.heartButton.tintColor = .black
            viewModel.removeFavorites(with: photo)
        }
    }
}
