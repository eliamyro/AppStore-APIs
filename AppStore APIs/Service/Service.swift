//
//  Service.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 12/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    func fetchApps(searchTerm: String, completion: @escaping(Result<[SearchResult], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResults =  try JSONDecoder().decode(SearchResults.self, from: data)
                completion(.success(searchResults.results))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func fetchGames(completion: @escaping(Result<AppGroup, Error>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/50/explicit.json"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                completion(.success(appGroup))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
