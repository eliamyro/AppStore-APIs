//
//  HorizontalSnappingController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 20/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class HorizontalSnappingController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        
        collectionView.decelerationRate = .fast
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
