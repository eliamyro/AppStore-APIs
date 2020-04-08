//
//  VerticalStackView.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 8/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach { addArrangedSubview($0) }
        
        self.axis = .vertical
        self.spacing = spacing
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
