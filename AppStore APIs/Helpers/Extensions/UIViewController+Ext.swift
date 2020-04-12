//
//  UIViewController+Ext.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 12/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertOnMainThread(title: String, message: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                self.dismiss(animated: true)
            }
            
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
    }
}
