//
//  Reviews.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 25/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entries: [Entry]
    
    enum CodingKeys: String, CodingKey {
        case entries = "entry"
    }
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
}

struct Label: Decodable {
    let label: String
}

struct Author: Decodable {
    let name: Label
}
