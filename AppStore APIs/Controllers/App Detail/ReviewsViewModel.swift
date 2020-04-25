//
//  ReviewsViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 24/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

protocol ReviewsViewModelDelegate: class {
    func reloadCollectionView()
}

class ReviewsViewModel {
    
    weak var delegate: ReviewsViewModelDelegate?
    
    var reviews: [Entry]? {
        didSet {
            delegate?.reloadCollectionView()
        }
    }
}
