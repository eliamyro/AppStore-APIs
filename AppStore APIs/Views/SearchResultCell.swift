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
    
    // MARK: - Views
    
    lazy var appImageView: UIImageView = {
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
        button.layer.cornerRadius = 14
        
        return button
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [appImageView, labelsStackView, getButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        backgroundColor = .green
        
        addViews()
        anchorViews()
    }
    
    private func addViews() {
        addSubview(infoStackView)
    }
    
    private func anchorViews() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: topAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            appImageView.widthAnchor.constraint(equalToConstant: 64),
            appImageView.heightAnchor.constraint(equalToConstant: 64),
            
            getButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
