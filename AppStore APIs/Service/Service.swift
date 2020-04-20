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
    
    func fetchApps(searchTerm: String, completion: @escaping(Result<SearchResults, Error>) -> Void) {
        let noSpaceTerm = searchTerm.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://itunes.apple.com/search?term=\(noSpaceTerm)&entity=software"
        fetchGenericsJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossingApps(completion: @escaping(Result<AppGroup, Error>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        fetchGenericsJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFreeGames(completion: @escaping(Result<AppGroup, Error>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/games/25/explicit.json"
        fetchGenericsJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchNewApps(completion: @escaping(Result<AppGroup, Error>) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/explicit.json"
        fetchGenericsJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping(Result<[SocialApp], Error>) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericsJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericsJSONData<T: Decodable>(urlString: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let socialApps = try JSONDecoder().decode(T.self, from: data)
                completion(.success(socialApps))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
