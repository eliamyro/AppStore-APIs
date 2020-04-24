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
    
    let viewModel: AppDetailViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: AppDetailViewModel) {
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
        
        navigationItem.largeTitleDisplayMode = .never
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.reuseIdentifier)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.reuseIdentifier)
    }
}

// MARK: - AppDetailViewModelDelegate

extension AppDetailController: AppDetailViewModelDelegate {
    func fetchSuccessful() {
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    func fetchFailed(error: Error) {
        showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension AppDetailController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.reuseIdentifier, for: indexPath) as! AppDetailCell
            cell.app = viewModel.app
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.reuseIdentifier, for: indexPath) as! PreviewCell
            cell.app = viewModel.app
            
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            let tempCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 800))
            tempCell.app = viewModel.app
            tempCell.layoutIfNeeded()
            let estimatedSize = tempCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 800))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct AppsDetailControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = AppDetailViewModel()
        viewModel.app = SearchResult(trackName: "Facebook", primaryGenreName: "Social", averageUserRating: 5, artworkUrl: "", screenshotUrls: ["", "", ""], formattedPrice: "3.99$", releaseNotes: "These are the release notes", description: "This is the app's description")
        
        
        let controller = AppDetailController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}
