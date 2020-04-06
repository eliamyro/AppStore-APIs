//
//  BaseTabBarController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 6/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavController(viewController: UIViewController(), title: Text.today, image: Image.today),
            createNavController(viewController: UIViewController(), title: Text.apps, image: Image.apps),
            createNavController(viewController: AppsSearchController(), title: Text.search, image: Image.search)
        ]
    }
    
    // MARK: - Helpers
    
    private func createNavController(viewController: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        return navController
    }
    
}
