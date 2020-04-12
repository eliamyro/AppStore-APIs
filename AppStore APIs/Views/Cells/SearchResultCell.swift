//
//  SearchResultCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 7/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SearchResultCell"
    
    var appResult: SearchResult? {
        didSet {
            updateViewsWithData()
        }
    }
    
    // MARK: - Views
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "App name"
        
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        
        return label
    }()
    
    lazy var ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.2M"
        
        return label
    }()
    
    lazy var getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    lazy var labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
    
    lazy var infoTopStackView = HorizontalStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton], alignment: .center, spacing: 12)
    
    lazy var screenshot1ImageView  = createScreenshotImageView()
    lazy var screenshot2ImageView  = createScreenshotImageView()
    lazy var screenshot3ImageView  = createScreenshotImageView()
    
    lazy var screeshotsStackView = HorizontalStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView],
                                                       distribution: .fillEqually,
                                                       spacing: 16)
    
    lazy var overalStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screeshotsStackView], spacing: 16)
    
    
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
        addViews()
        anchorViews()
    }
    
    private func addViews() {
        addSubview(overalStackView)
    }
    
    private func anchorViews() {
        overalStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
    }
    
    private func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        
        return imageView
    }
    
    private func updateViewsWithData() {
        guard let appResult = appResult else { return }
        
        nameLabel.text = appResult.trackName
        categoryLabel.text = appResult.primaryGenreName
        ratingsLabel.text = "\(appResult.averageUserRating ?? 0)"
    }
}
