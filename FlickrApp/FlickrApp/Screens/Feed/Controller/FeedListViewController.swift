//
//  FeedController.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit
import Kingfisher

final class FeedListViewController: UIViewController{
    private var viewModel: FeedListViewModel
    private let feedListView = FeedListView()
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

extension FeedListViewController: UITableViewDelegate, UITableViewDataSource {
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
        
//        cell.feedImageView.kf.setImage(with: photo.urlC)
        var imgurl = URL(string: photo.urlC ?? "")
        cell.feedImageView.kf.setImage(with: imgurl)
        cell.configureCell(photo: photo)
        return cell
    }
}
