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
    
    func fetchApps(completion: @escaping(Result<[SearchResult], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
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
}
