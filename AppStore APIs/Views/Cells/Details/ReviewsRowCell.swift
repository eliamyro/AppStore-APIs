//
//  ReviewCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 24/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class ReviewsRowCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ReviewsRowCell"
    
    var reviews: Reviews? {
        didSet {
            guard let reviews = reviews else { return }
            reviewsController.viewModel.reviews = reviews.feed.entries
        }
    }
    
    let reviewsController = ReviewsController(viewModel: ReviewsViewModel())
    
    // MARK: - Views
       
    lazy var titleLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 20))
    
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
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(titleLabel)
        addSubview(reviewsController.view)
        
    }
    
    private func anchorViews() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 0))
        reviewsController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(top: 16, left: 0, bottom: 16, right: 0))
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct ReviewsRowCellPreview: PreviewProvider {
    static var previews: some View {
        
        let view = ReviewsRowCell()
        return view.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 500, height: 300))
    }
}
