//
//  SearchResultCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 7/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit
import SDWebImage

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
        imageView.clipsToBounds = true
        
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
        button.setTitle(Text.get, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        
        return imageView
    }
    
    private func updateViewsWithData() {
        guard let appResult = appResult else { return }
        
        nameLabel.text = appResult.trackName
        categoryLabel.text = appResult.primaryGenreName
        ratingsLabel.text = "\(appResult.averageUserRating ?? 0)"
        
        guard let appIconUrl = URL(string:appResult.artworkUrl) else { return }
        appIconImageView.sd_setImage(with: appIconUrl)
        
        screenshot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
        
        if appResult.screenshotUrls.count > 1 {
            screenshot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
        }
        
        if appResult.screenshotUrls.count > 2 {
            screenshot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
        }
    }
}
