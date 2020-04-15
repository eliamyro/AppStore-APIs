//
//  AppHeaderCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppsHeaderCell"
    
    // MARK: - Views
    
    lazy var companyLabel: UILabel = {
        let label = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 14))
        label.textColor = .blue
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(text: "Keeping up with friends is faster than ever.", font: .systemFont(ofSize: 24))
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 8)
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    lazy var appInfoStackView = VerticalStackView(arrangedSubviews: [companyLabel, descriptionLabel, appIconImageView], spacing: 12)
    
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
        addSubview(appInfoStackView)
    }
    
    private func anchorViews() {
        appInfoStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
}