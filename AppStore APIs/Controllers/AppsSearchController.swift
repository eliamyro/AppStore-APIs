//
//  AppsSearchController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 7/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var appResults = [SearchResult]()
    
    private var timer: Timer?
    
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
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
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
        navigationItem.searchController = appsSearchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reuseIdentifier)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.anchorCenterXToView(view: collectionView)
        enterSearchTermLabel.anchor(top: collectionView.topAnchor, margin: .init(top: 100, left: 0, bottom: 0, right: 0))
    }
    
    private func fetchITunesApps(searhTerm: String) {
        Service.shared.fetchApps(searchTerm: searhTerm) { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.appResults = searchResults
                DispatchQueue.main.async { self?.collectionView.reloadData() }
            case .failure(let error):
                self?.showAlertOnMainThread(title: Text.error, message: error.localizedDescription, actionTitle: Text.ok)
            }
        }
    }
}

// MARK: UICollectionViewDatasource

extension AppsSearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        
        return cell
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
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.fetchITunesApps(searhTerm: searchText)
        })
    }
}
