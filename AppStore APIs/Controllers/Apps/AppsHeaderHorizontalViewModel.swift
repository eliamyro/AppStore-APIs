//
//  AppsHeaderHorizontalViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

protocol AppsHeadereHorizontalViewModelDelegate: class {
    func reloadCollectionView()
}

class AppsHeaderHorizontalViewModel {
    
    // MARK: - Properties
    
    weak var delegate: AppsHeadereHorizontalViewModelDelegate?
    
    var socials = [SocialApp]()
    
    var socialApps: [SocialApp]? {
        didSet {
            guard let socialApps = socialApps else { return }
            socials = socialApps
            delegate?.reloadCollectionView()
        }
    }
}
