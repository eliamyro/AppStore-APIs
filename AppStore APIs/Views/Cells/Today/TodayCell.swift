//
//  TodayCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 26/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TodayCell"
    
    var todayItem: TodayItem? {
        didSet {
            configureViewsWithTodayItem()
        }
    }
    
    // MARK: - Views
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "LIFE HACK"
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Utilizing your time"
        label.font = .boldSystemFont(ofSize: 26)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "All the tools and apps you need to inteligently organize your life the right way"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var imageContainerView = UIView()
    
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.garden
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var todayStackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
    
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
        layer.cornerRadius = 16
        
        addViews()
        anchorViews()
    }
    
    private func configureViewsWithTodayItem() {
        guard let todayItem = todayItem else { return }
        
        backgroundColor = todayItem.backgroundColor
        categoryLabel.text = todayItem.category
        titleLabel.text = todayItem.title
        descriptionLabel.text = todayItem.description
        cardImageView.image = todayItem.image
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(todayStackView)
    }
    
    private func anchorViews() {
        todayStackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        
        imageContainerView.addSubview(cardImageView)
        cardImageView.anchorHeightWidth(heightConstant: 240, widthConstant: 240)
        cardImageView.anchorCenterToView(view: self)
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct TodayCellPreview: PreviewProvider {
    static var previews: some View {
        
        let view = TodayCell()
        return view.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 400, height: 450))
    }
}
