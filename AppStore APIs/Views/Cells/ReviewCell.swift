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
    
    // MARK: - Views
    
    lazy var titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    lazy var authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    lazy var starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    lazy var bodyLabel = UILabel(text: "Review Body, Review Body, Review Body\nReview Body, Review Body, Review Body\nReview Body, Review Body, Review Body\nReview Body, Review Body, Review Body\n", font: .systemFont(ofSize: 14), numberOfLines: 0)
    
    lazy var titleAuthorStackView = HorizontalStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel])
    lazy var reviewStackView = VerticalStackView(arrangedSubviews: [titleAuthorStackView, starsLabel, bodyLabel], spacing: 8)
    
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
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(reviewStackView)
    }
    
    private func anchorViews() {
        reviewStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
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
