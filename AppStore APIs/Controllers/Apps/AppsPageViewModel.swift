//
//  AppsPageViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 23/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

protocol AppsPageViewModelDelegate: class {
    func fetchSuccessful()
    func fetchFailed(error: Error)
}

class AppsPageViewModel {
    
    // MARK: - Properties
    
    var appGroups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    weak var delegate: AppsPageViewModelDelegate?
    
    // MARK: - Helpers
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topFreeGroup: AppGroup?
        var topGrossingGroup: AppGroup?
        var newAppsGroup: AppGroup?
        var fetchError: Error?
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { result in
            dispatchGroup.leave()
            switch result {
            case .success(let socialApps):
                self.socialApps = socialApps
            case .failure(let error):
                fetchError = error
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
                self?.delegate?.fetchFailed(error: error)
                return
            }
            
            self?.delegate?.fetchSuccessful()
        }
    }
}
