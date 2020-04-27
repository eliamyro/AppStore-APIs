//
//  AppFullScreenDescriptionCell.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 27/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppFullScreenDescriptionCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "AppFullScreenDescriptionCell"
    
    // MARK: - Views
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configure() {
        addViews()
        anchorViews()
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        addSubview(descriptionLabel)
    }
    
    private func anchorViews() {
        descriptionLabel.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
    }
}


// MARK: - PreviewProvider

import SwiftUI

struct AppFullScreenDescriptionCellPreview: PreviewProvider {
    static var previews: some View {
        
        let view = AppFullScreenDescriptionCell()
        return view.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 400, height: 450))
    }
}
