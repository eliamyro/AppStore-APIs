//
//  ScreenshotCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 22/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit
import SDWebImage

class ScreenshotCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ScreenshotCell"
    
    var screenshotUrl: String? {
        didSet {
            configureScreenshot()
        }
    }
    
    // MAR: - Views
    
    lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .purple
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
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
        addViews()
        anchorViews()
    }
    
    private func configureScreenshot() {
        guard let screenshotUrl = screenshotUrl else { return }
        screenshotImageView.sd_setImage(with: URL(string: screenshotUrl))
    }
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(screenshotImageView)
    }
    
    private func anchorViews() {
        screenshotImageView.fillSuperview()
    }
}
