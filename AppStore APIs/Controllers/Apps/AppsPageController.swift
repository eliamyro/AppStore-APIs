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
    
    let viewModel: AppsPageViewModel
    
    // MARK: - Views
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: AppsPageViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        viewModel.fetchData()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        viewModel.delegate = self
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.reuseIdentifier)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AppsPageHeader.reuseIdentifier)
        
        addViews()
        anchorViews()
        
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        view.addSubview(activityIndicator)
    }
    
    private func anchorViews() {
        activityIndicator.anchorCenterToView(view: view)
    }
}

// MARK: - AppsPageViewModelDelegate

extension AppsPageController: AppsPageViewModelDelegate {
    func fetchSuccessful() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
    
    func fetchFailed(error: Error) {
        activityIndicator.stopAnimating()
        showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
    }
}

// MARK: - UICollectionViewDatasource

extension AppsPageController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.appGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.reuseIdentifier, for: indexPath) as! AppsGroupCell
        cell.appGroup = viewModel.appGroups[indexPath.item]
        cell.horizontalController.didSelectHandler = { [weak self] app in
            let appDetailController = AppDetailController(viewModel: AppDetailViewModel())
            appDetailController.viewModel.appId = app.id
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsPageHeader.reuseIdentifier, for: indexPath) as! AppsPageHeader
        header.socialApps = viewModel.socialApps
        
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


// MARK: - PreviewProvider

import SwiftUI

struct AppsPageControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = AppsPageViewModel()
        viewModel.socialApps = [
            SocialApp(id: "1", name: "Facebook", imageUrl: "", tagline: "Tagline"),
            SocialApp(id: "1", name: "Facebook", imageUrl: "", tagline: "Tagline")]
        
        viewModel.appGroups = [
            AppGroup(feed:
                Feed(title: "Section 1", results: [
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: ""),
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: ""),
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: ""),
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: ""),
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: ""),
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: "")])),
            AppGroup(feed:
                Feed(title: "Section 2", results: [
                    FeedResult(id: "1", name: "Facebook", artistName: "Facebook", artworkUrl: "")]))]
        
        
        let controller = AppsPageController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}
