//
//  AppDetailController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 20/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    // MARK: - Properties
    
    var app: FeedResult? {
        didSet {
            configureViewsWithFeedResult()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        collectionView.backgroundColor = .white
    }
    
    private func configureViewsWithFeedResult() {
        guard let app = app else { return }
        
        navigationItem.title = app.name
    }
}
