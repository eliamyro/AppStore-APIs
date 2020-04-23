//
//  AppSearchViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

// MARK: - AppSearchViewModelDelegate

protocol AppSearchViewModelDelegate: class {
    func iTunesAppsFetchSuccessful()
    func iTunesAppsFetchFailed(error: Error)
}

class AppSearchViewModel {
    
    // MARK: - Properties
    private var timer: Timer?
    var appResults = [SearchResult]()
    
    weak var delegate: AppSearchViewModelDelegate?
    
    // MARK: - Helpers
    
    func fetchITunesApps(searchTerm: String) {
        Service.shared.fetchApps(searchTerm: searchTerm) { [weak self] result in
            switch result {
            case .success(let searchResults):
                self?.appResults = searchResults.results
                self?.delegate?.iTunesAppsFetchSuccessful()
            case .failure(let error):
                self?.delegate?.iTunesAppsFetchFailed(error: error)
            }
        }
    }
    
    func textDidChange(searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.fetchITunesApps(searchTerm: searchText)
        })
    }
}
