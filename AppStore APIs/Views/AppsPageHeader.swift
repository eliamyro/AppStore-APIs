//
//  AppsPageHeader.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppsPageHeader"
    
    lazy var appHeadereHorizontalController = AppsHeaderHorizontalController()
    
    var socialApps: [SocialApp]? {
        didSet {
            guard let socialApps = socialApps else { return }
            appHeadereHorizontalController.socialApps = socialApps
        }
    }
    
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
        backgroundColor = .blue
        
        addViews()
        anchorViews()
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(appHeadereHorizontalController.view)
    }
    
    private func anchorViews() {
        appHeadereHorizontalController.view.fillSuperview()
    }
}
