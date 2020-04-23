//
//  AppHorizontalViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

class AppsHorizontalViewModel {
    
    // MARK: - Properties
    
    var apps = [FeedResult]()
    
    var appGroup: AppGroup? {
        didSet {
            guard let appGroup = appGroup else { return }
            apps =  appGroup.feed.results
        }
    }
}
