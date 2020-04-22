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
    
    var appId: String? {
        didSet {
            fetchAppDetails()
        }
    }
    
    var app: SearchResult?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        navigationItem.largeTitleDisplayMode = .never
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.reuseIdentifier)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.reuseIdentifier)
    }
    
    private func fetchAppDetails() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericsJSONData(urlString: urlString) { [weak self] (result: Result<SearchResults, Error>) in
            switch result {
            case .success(let apps):
                self?.app = apps.results.first
                DispatchQueue.main.async { self?.collectionView.reloadData() }
            case .failure(let error):
                self?.showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
            }
        }
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension AppDetailController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.reuseIdentifier, for: indexPath) as! AppDetailCell
            cell.app = app
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.reuseIdentifier, for: indexPath) as! PreviewCell
            cell.app = app
            
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
            tempCell.app = app
            tempCell.layoutIfNeeded()
            let estimatedSize = tempCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 800))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        } else {
            return .init(width: view.frame.width, height: 500)
        }
    }
}
