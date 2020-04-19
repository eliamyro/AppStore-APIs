//
//  SocialApp.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 19/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import Foundation

struct SocialApp: Decodable {
    let id: String
    let name: String
    let imageUrl: String
    let tagline: String
}
