//
//  AppDetailCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 21/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppDetailCell"
    
    // MARK: - Views
    
    lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(cornerRadius: 16)
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    lazy var nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    
    lazy var priceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("4.99$", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2009405196, green: 0.4603905082, blue: 0.9551178813, alpha: 1)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 32 / 2
        
        return button
    }()
    
    lazy var whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    
    lazy var releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    lazy var mainStackView = VerticalStackView(arrangedSubviews: [iconInfoStackView, whatsNewLabel, releaseNotesLabel], spacing: 16)
    
    lazy var iconInfoStackView = HorizontalStackView(arrangedSubviews: [appIconImageView, infoStackView], spacing: 16)
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, UIView(), priceButton])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 12
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
        backgroundColor = .red
        
        addViews()
        anchorViews()
    }
    
    private func addViews() {
        addSubview(mainStackView)
    }
    
    private func anchorViews() {
        mainStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
        appIconImageView.anchorHeightWidth(heightConstant: 120, widthConstant: 120)
        priceButton.anchorHeightWidth(heightConstant: 32, widthConstant: 80)
    }
}
