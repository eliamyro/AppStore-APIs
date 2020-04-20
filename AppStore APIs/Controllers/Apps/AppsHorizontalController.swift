//
//  AppsHorizontalController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    // MARK: - Properties
    
    var appGroup: AppGroup? {
        didSet {
            configureViewsWithAppGroup()
        }
    }
    
    var apps = [FeedResult]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    private func configureViewsWithAppGroup() {
        guard let appGroup = appGroup else { return }
        apps =  appGroup.feed.results
    }
}

    // MARK: - UICollectionViewDatasource

extension AppsHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.reuseIdentifier, for: indexPath) as! AppRowCell
        cell.app = apps[indexPath.item]
        
        return cell
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 48
        let height = (view.frame.height - 24 - 20) / 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
