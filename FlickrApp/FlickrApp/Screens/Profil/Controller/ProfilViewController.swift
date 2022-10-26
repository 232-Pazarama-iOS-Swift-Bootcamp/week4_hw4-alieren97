//
//  ProfilViewController.swift
//  FlickrApp
//
//  Created by Ali Eren on 25.10.2022.
//

import Foundation
import UIKit
import Kingfisher

final class ProfilViewController: UIViewController {
    
    private let profilView = ProfilView()
    private var viewModel: ProfilViewModel

    
    enum FetchType: String {
        case likes = "likes"
        case saved = "saved"
        
        init(text: String) {
            switch text {
            case "likes":
                self = .likes
            case "saved":
                self = .saved
            default:
                self = .likes
            }
        }
        
    }
    
    var fetchType: FetchType = .likes {
        didSet{
            viewModel.fetchPhotosForProfile(with: fetchType.rawValue)
            profilView.collectionView.reloadData()
        }
    }
    
    init(viewModel: ProfilViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profil"
        view = profilView
        profilView.backgroundColor = .white
        navigationItem.title = "Profil"
        setupCollectionView()
        profilView.segmentedControl.addTarget(self, action: #selector(didValueChangedSegmentedControl), for: .valueChanged)
       
        
    }
    
    @IBAction private func didValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let index = profilView.segmentedControl.selectedSegmentIndex
        if (index == 1) {
            fetchType = FetchType(text: "likes")
        } else {
            fetchType = FetchType(text: "saved")
        }
    }
}


extension ProfilViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        profilView.collectionView.delegate = self
        profilView.collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel.listPhotos[indexPath.row] as! String
        print(item)
        
        guard let cell: LikesAndSavedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: LikesAndSavedCollectionViewCell.identifier, for: indexPath) as? LikesAndSavedCollectionViewCell else {
            return UICollectionViewCell()
        }
        let img = URL(string: item)
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
