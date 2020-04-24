//
//  AppDetailViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

// MARK: - AppDetailViewModelDelegate

protocol AppDetailViewModelDelegate: class {
    func fetchSuccessful()
    func fetchFailed(error: Error)
}

class AppDetailViewModel {
    
    // MARK: - Properties
    
    weak var delegate: AppDetailViewModelDelegate?
    
    var app: SearchResult?
    var reviews: Reviews?
    
    var appId: String? {
        didSet {
            fetchAppDetails()
            fetchReviews()
        }
    }
    
    // MARK: - Helpers
    
    func fetchAppDetails() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
        Service.shared.fetchGenericsJSONData(urlString: urlString) { [weak self] (result: Result<SearchResults, Error>) in
            switch result {
            case .success(let apps):
                self?.app = apps.results.first
                self?.delegate?.fetchSuccessful()
            case .failure(let error):
                self?.delegate?.fetchFailed(error: error)
            }
        }
    }
    
    func fetchReviews() {
        guard let appId = appId else { return }
        let urlString = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
        
        Service.shared.fetchGenericsJSONData(urlString: urlString) { (result: Result<Reviews, Error>) in
            switch result {
            case .success(let reviews):
                self.reviews = reviews
                self.delegate?.fetchSuccessful()
            case .failure(let error):
                self.delegate?.fetchFailed(error: error)
            }
        }
    }
}
