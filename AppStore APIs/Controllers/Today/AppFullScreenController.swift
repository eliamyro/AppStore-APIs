//
//  AppFullScreenController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 27/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {
    
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
        let header = TodayCell()
        return header
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

