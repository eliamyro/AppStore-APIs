//
//  HorizontalStackView.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 8/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class HorizontalStackView: UIStackView {
    
    // MARK: - Lifecycle
    
    init(arrangedSubviews: [UIView], distribution: Distribution = .fill, alignment: Alignment = .fill, spacing: CGFloat = 0) {
        super.init(frame: .zero)
        
        arrangedSubviews.forEach { addArrangedSubview($0) }
        
        self.axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
