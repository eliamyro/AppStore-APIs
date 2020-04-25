//
//  ReviewCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 24/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ReviewCell"
    
    var review: Entry? {
        didSet {
            configureViewsWithReview()
        }
    }
    
    // MARK: - Views
    
    lazy var titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author Author Author"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        
        return label
    }()
    
    lazy var ratingStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        
        (0 ..< 5).forEach { _ in
            let starImageView = UIImageView(image:Image.star)
            starImageView.tintColor = .systemYellow
            starImageView.anchorHeightWidth(heightConstant: 24, widthConstant: 24)
            arrangedSubviews.append(starImageView)
        }
        
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .horizontal
        
        return stackView
    }()
    lazy var bodyLabel = UILabel(text: "Review Body", font: .systemFont(ofSize: 14), numberOfLines: 5)
    
    lazy var titleAuthorStackView = HorizontalStackView(arrangedSubviews: [titleLabel, authorLabel], spacing: 8)
    lazy var reviewStackView = VerticalStackView(arrangedSubviews: [titleAuthorStackView, ratingStackView, bodyLabel], spacing: 12)
    
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
        backgroundColor = #colorLiteral(red: 0.9214740396, green: 0.9170920253, blue: 0.950124681, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addViews()
        anchorViews()
    }
    
    private func configureViewsWithReview() {
        guard let review = review else { return }
        
        titleLabel.text = review.title.label
        authorLabel.text = review.author.name.label
        bodyLabel.text = review.content.label
        
        for(index, view) in ratingStackView.arrangedSubviews.enumerated() {
            if let ratingInt = Int(review.rating.label) {
                view.alpha = index >= ratingInt ? 0 : 1
            }
        }
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(reviewStackView)
    }
    
    private func anchorViews() {
        reviewStackView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct ReviewCellPreview: PreviewProvider {
    static var previews: some View {
        
        let view = ReviewCell()
        return view.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 500, height: 300))
    }
}
