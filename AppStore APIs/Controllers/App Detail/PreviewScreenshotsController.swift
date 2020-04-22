//
//  PreviewScreenshotsController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 22/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class PreviewScreenshotsController: HorizontalSnappingController {
    
    // MARK: - Properties
    
    var screenshots = [String]()
    
    var app: SearchResult? {
        didSet {
            guard let urlStrings = app?.screenshotUrls else { return }
            screenshots = urlStrings
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
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension PreviewScreenshotsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as! ScreenshotCell
        cell.screenshotUrl = screenshots[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
