//
//  UIButton+Ext.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
    }
}
