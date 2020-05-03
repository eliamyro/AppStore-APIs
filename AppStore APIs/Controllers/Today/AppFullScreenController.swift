//
//  AppFullScreenController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 27/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
    // MARK: - Properties
    
    var dismissHandler: (() -> ())?
    
    // MARK: - Views
    
    lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24)
        button.setImage(Image.close?.withConfiguration(symbolConfig), for: .normal)
        button.tintColor = #colorLiteral(red: 0.2009405196, green: 0.4603905082, blue: 0.9551178813, alpha: 1)
        
        button.addTarget(self, action: #selector(handleDismissButton), for: .touchUpInside)
        return button
    }()
    
    lazy var todayCell = TodayCell()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        view.backgroundColor = .white
        
        tableView.register(AppFullScreenDescriptionCell.self, forCellReuseIdentifier: AppFullScreenDescriptionCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        addViews()
        anchorViews()
    }
    
    // MARK: - Constraints
    
    private func addViews() {
        todayCell.addSubview(dismissButton)
    }
    
    private func anchorViews() {
        dismissButton.anchor(top: todayCell.topAnchor, trailing: todayCell.trailingAnchor, margin: .init(top: 0, left: 0, bottom: 0, right: 16))
    }
    
    // MARK: - Selectors
    
    @objc private func handleDismissButton() {
        dismissButton.isHidden = true
        dismissHandler?()
    }
}

// MARK: - UITableViewDatasource - UITableViewDelegate

extension AppFullScreenController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AppFullScreenDescriptionCell.reuseIdentifier, for: indexPath) as! AppFullScreenDescriptionCell
        
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return todayCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 450
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct AppFullScreenControllerPreview: PreviewProvider {
    static var previews: some View {
        
        let controller = AppFullScreenController()
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}

