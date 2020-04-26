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
    
    // MARK: - Views
    
    lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.garden
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        backgroundColor = .white
        layer.cornerRadius = 16
        
        addViews()
        anchorViews()
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(cardImageView)
    }
    
    private func anchorViews() {
        cardImageView.anchorHW(width: widthAnchor, wMultiplier: 0.7)
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
