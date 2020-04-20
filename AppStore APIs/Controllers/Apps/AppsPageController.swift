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
    
    var appGroups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    // MARK: - Views
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
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
        
        addViews()
        anchorViews()
        
    }
    
    private func addViews() {
        view.addSubview(activityIndicator)
    }
    
    private func anchorViews() {
        activityIndicator.anchorCenterToView(view: view)
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topFreeGroup: AppGroup?
        var topGrossingGroup: AppGroup?
        var newAppsGroup: AppGroup?
        var fetchError: Error?
        
        Service.shared.fetchSocialApps { result in
            switch result {
            case .success(let socialApps):
                self.socialApps = socialApps
            case .failure(let error):
                print(error)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeGames { result in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                topFreeGroup = appGroup
            case .failure(let error):
                fetchError = error
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossingApps { result in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                topGrossingGroup = appGroup
            case .failure(let error):
                fetchError = error
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchNewApps { result in
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                newAppsGroup = appGroup
            case .failure(let error):
                fetchError = error
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.activityIndicator.stopAnimating()
            
            if let group = topFreeGroup {
                self?.appGroups.append(group)
            }
            
            if let group = topGrossingGroup {
                self?.appGroups.append(group)
            }
            
            if let group = newAppsGroup {
                self?.appGroups.append(group)
            }
            
            if let error = fetchError {
                self?.showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
            }
            
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDatasource

extension AppsPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.reuseIdentifier, for: indexPath) as! AppsGroupCell
        cell.appGroup = appGroups[indexPath.item]
        cell.horizontalController.didSelectHandler = { [weak self] app in
            let appDetailController = AppDetailController()
            appDetailController.app = app
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeader.reuseIdentifier, for: indexPath) as! AppsPageHeader
        header.socialApps = socialApps
        
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
