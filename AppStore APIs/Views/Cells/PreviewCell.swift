//
//  PreviewCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 22/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "PreviewCell"
    
    let screenshotsController = PreviewScreenshotsController()
    
    var app: SearchResult? {
        didSet {
            configureWithSearchResult()
        }
    }
    
    lazy var divider: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        
        return view
    }()
    
    lazy var previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    
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
    
    private func configureWithSearchResult() {
        guard let app = app else { return }
        screenshotsController.app = app
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(divider)
        addSubview(previewLabel)
        addSubview(screenshotsController.view)
    }
    
    private func anchorViews() {
        divider.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 1))
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        screenshotsController.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
