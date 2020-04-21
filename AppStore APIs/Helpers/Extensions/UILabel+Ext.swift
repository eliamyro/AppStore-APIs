//
//  UILabel+Ext.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
