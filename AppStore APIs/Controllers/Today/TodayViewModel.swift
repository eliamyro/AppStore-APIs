//
//  TodayViewModel.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 26/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class TodayViewModel {
    var startingFrame: CGRect?
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    let items = [
        TodayItem(category: "LIFE HACK", title: "Utilizing your Time", image: Image.garden, description: "All the tools and apps you need to inteligently organize your life the right way", backgroundColor: .white),
        TodayItem(category: "HOLIDAYS", title: "Travel on a Budget", image: Image.holiday, description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1))
    ]
}
