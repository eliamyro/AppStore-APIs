//
//  SearchResult.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 8/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let artworkUrl: String
    let screenshotUrls: [String]
    let formattedPrice: String?
    let releaseNotes: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case trackName, primaryGenreName, averageUserRating, screenshotUrls, formattedPrice, releaseNotes, description
        case artworkUrl = "artworkUrl512"
    }
}
