//
//  GamesResult.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id: String
    let name: String
    let artistName: String
    let artworkUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, artistName
        case artworkUrl = "artworkUrl100"
    }
}
