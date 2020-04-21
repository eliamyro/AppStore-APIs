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
    }
    
    private func fetchAppDetails() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericsJSONData(urlString: urlString) { [weak self] (result: Result<SearchResults, Error>) in
            switch result {
            case .success(let apps):
                print(apps.results.first?.releaseNotes)
            case .failure(let error):
                self?.showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
            }
        }
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension AppDetailController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.reuseIdentifier, for: indexPath) as! AppDetailCell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width, height: 300)
    }
}
