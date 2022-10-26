//
//  SearchController.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import UIKit

final class SearchViewController: UIViewController{
    
    private var viewModel: SearchViewModel
    let searchView = SearchView()
   
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.backgroundColor = .white
        configureCollectionView()
      
        viewModel.fetchSearchTagPhotos(tag: "popular")
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchPhotos:
                self.searchView.collectionView.reloadData()
            case .didErrorOccurred(let error):
               print(error
               )
            }
        }
        
        searchView.doneButton.addTarget(self, action: #selector(doneButtonDidTapped), for: .touchUpInside)

        
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @objc func doneButtonDidTapped() {
        guard let text = searchView.searchTextField.text else {return}
        print(text)
        viewModel.fetchSearchTagPhotos(tag: text)
    }
    func configureCollectionView() {
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: LikesAndSavedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesAndSavedCollectionViewCell.identifier, for: indexPath) as? LikesAndSavedCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let photo = viewModel.coinForIndexPath(indexPath) else {
            fatalError("coin not found.")
        }
        let img = URL(string: photo.urlC ?? "")
        cell.photoImageView.kf.setImage(with: img)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/3.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
}
