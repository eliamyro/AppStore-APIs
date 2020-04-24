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
    
    let viewModel: PreviewScreenshotsViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: PreviewScreenshotsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        viewModel.delegate = self
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

// MARK: - PreviewScreenshotsViewModelDelegate

extension PreviewScreenshotsController: PreviewScreenshotsViewModelDelegate {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension PreviewScreenshotsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.screenshotsUrls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseIdentifier, for: indexPath) as! ScreenshotCell
        cell.screenshotUrl = viewModel.screenshotsUrls[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct PreviewScreenshotsControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = PreviewScreenshotsViewModel()
        viewModel.screenshotsUrls = ["", "", "", ""]
        
        let controller = PreviewScreenshotsController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 400, height: 500))
    }
}
