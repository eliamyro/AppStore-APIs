//
//  AppsHeaderHorizontalController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController {
    
    // MARK: - Properties
    var socials = [SocialApp]()
    
    var socialApps: [SocialApp]? {
        didSet {
            guard let socialApps = socialApps else { return }
            socials = socialApps
            collectionView.reloadData()
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
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: AppsHeaderCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UICollectionViewDatasource
extension AppsHeaderHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return socials.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCell.reuseIdentifier, for: indexPath) as! AppsHeaderCell
        cell.socialApp = socials[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
}
