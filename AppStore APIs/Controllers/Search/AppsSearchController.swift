//
//  AppsSearchController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 7/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsSearchController: BaseListController {
    
    // MARK: - Properties
    
    let viewModel: AppSearchViewModel
    
    // MARK: - Views
    
    lazy var appsSearchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    lazy var enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = Text.enterSearchTerm
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(viewModel: AppSearchViewModel) {
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
        
        navigationItem.searchController = appsSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reuseIdentifier)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.anchorCenterXToView(view: collectionView)
        enterSearchTermLabel.anchor(top: collectionView.topAnchor, margin: .init(top: 100, left: 0, bottom: 0, right: 0))
    }
}

// MARK: - AppsSearchViewModel

extension AppsSearchController: AppSearchViewModelDelegate {
    func iTunesAppsFetchSuccessful() {
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    func iTunesAppsFetchFailed(error: Error) {
        showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
    }
}

// MARK: UICollectionViewDatasource

extension AppsSearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = viewModel.appResults.count != 0
        return viewModel.appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.appResult = viewModel.appResults[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appId = "\(viewModel.appResults[indexPath.item].trackId)"
        let detailController = AppDetailController(viewModel: AppDetailViewModel(appId: appId))
        navigationController?.pushViewController(detailController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 320)
    }
}

// MARK: - UISearchBarDelegate

extension AppsSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(searchText: searchText)
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct AppsSearchControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = AppSearchViewModel()
        viewModel.appResults = [SearchResult(trackId: 1, trackName: "Facebook", primaryGenreName: "Social", averageUserRating: 5, artworkUrl: "", screenshotUrls: ["","","",""], formattedPrice: "3.99$", releaseNotes: "", description: ""),
        SearchResult(trackId: 1, trackName: "Facebook", primaryGenreName: "Social", averageUserRating: 5, artworkUrl: "", screenshotUrls: ["","","",""], formattedPrice: "3.99$", releaseNotes: "", description: ""),
        SearchResult(trackId: 1, trackName: "Facebook", primaryGenreName: "Social", averageUserRating: 5, artworkUrl: "", screenshotUrls: ["","","",""], formattedPrice: "3.99$", releaseNotes: "", description: "")]
        
        let controller = AppsSearchController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}
