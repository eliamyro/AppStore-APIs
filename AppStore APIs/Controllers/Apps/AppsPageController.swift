//
//  AppsController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {
    
    // MARK: - Properties
    
    var appGroup = [AppGroup]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchData()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.reuseIdentifier)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsPageHeader.reuseIdentifier)
        
    }
    
    private func fetchData() {
        Service.shared.fetchGames { [weak self] result in
            switch result {
            case .success(let appGroup):
                self?.appGroup.append(appGroup)
                DispatchQueue.main.async { self?.collectionView.reloadData() }
            case .failure(let error):
                self?.showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
            }
        }
    }
}

// MARK: - UICollectionViewDatasource

extension AppsPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.reuseIdentifier, for: indexPath) as! AppsGroupCell
        cell.appGroup = appGroup[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeader.reuseIdentifier, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
