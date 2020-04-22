//
//  AppRowCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit
import SDWebImage

class AppRowCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppRowCell"
    
    var app: FeedResult? {
        didSet {
            configureCellWithFeedResult()
        }
    }
    
    // MARK: - Views
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    lazy var nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    
    lazy var companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    lazy var getButton: UIButton = {
        let button = UIButton(title: Text.get)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius = 32/2
        
        return button
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel]), getButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        
        return stackView
    }()
    
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
    
    private func configureCellWithFeedResult() {
        guard let app = app else { return }
        
        nameLabel.text = app.name
        companyLabel.text = app.artistName
        appIconImageView.sd_setImage(with: URL(string: app.artworkUrl))
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(infoStackView)
    }
    
    private func anchorViews() {
        infoStackView.fillSuperview()
        appIconImageView.anchorHeightWidth(heightConstant: 64, widthConstant: 64)
        getButton.anchorHeightWidth(heightConstant: 32, widthConstant: 80)
    }
}
