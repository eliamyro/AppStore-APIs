//
//  AppsGroupCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppsGroupCell"
    
    var appGroup: AppGroup? {
        didSet {
            configureGroupViewWithData()
        }
    }
    
    // MARK: - Views
    
    lazy var titleLabel = UILabel(text: "APP SECTION", font: .boldSystemFont(ofSize: 26))
    
    lazy var horizontalController = AppsHorizontalController(viewModel: AppsHorizontalViewModel())
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        backgroundColor = .white
        
        addViews()
        anchorViews()
    }
    
    private func configureGroupViewWithData() {
        guard let appGroup = appGroup else { return }
        titleLabel.text = appGroup.feed.title
        horizontalController.viewModel.appGroup = appGroup
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(horizontalController.view)
    }
    
    private func anchorViews() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 0, left: 16, bottom: 0, right: 0))
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
