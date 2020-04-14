//
//  AppsController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsController: BaseListController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDatasource

extension AppsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
