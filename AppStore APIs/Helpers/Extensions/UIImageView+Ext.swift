//
//  UIImageView+Ext.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 14/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
