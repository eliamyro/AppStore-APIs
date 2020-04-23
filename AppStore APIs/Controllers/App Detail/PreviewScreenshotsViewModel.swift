//
//  PreviewScreenshotsViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

// MARK: - PreviewScreenshotsViewModelDelegate

protocol PreviewScreenshotsViewModelDelegate: class {
    func reloadCollectionView()
}

class PreviewScreenshotsViewModel {
    
    // MARK: - Properties
    
    weak var delegate: PreviewScreenshotsViewModelDelegate?
    
    var screenshotsUrls = [String]()
    
    var app: SearchResult? {
        didSet {
            guard let urlStrings = app?.screenshotUrls else { return }
            screenshotsUrls = urlStrings
            delegate?.reloadCollectionView()
        }
    }
}
