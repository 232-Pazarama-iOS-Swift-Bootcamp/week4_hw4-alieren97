//
//  FeedListView.swift
//  FlickrApp
//
//  Created by Ali Eren on 24.10.2022.
//

import Foundation
import SnapKit
import UIKit

final class FeedListView: UIView {
    
    lazy var feedListTableView: UITableView = {
        let tv = UITableView()
        tv.register(FeedListTableViewCell.self, forCellReuseIdentifier: FeedListTableViewCell.identifier)
        tv.rowHeight = UIScreen.main.bounds.width + 100
        return tv
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
        addSubview(feedListTableView)
    }
    
    private func setupLayouts() {
        feedListTableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}

