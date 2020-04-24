//
//  UIViewController+LivePreview.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 24/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit
import SwiftUI

extension UIViewController {
    var liveView: some View {
        LiveViewController(viewController: self)
    }
    
    struct LiveViewController<VC: UIViewController>: UIViewControllerRepresentable {
        let viewController: VC
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LiveViewController<VC>>) -> VC {
            return viewController
        }
    
        func updateUIViewController(_ uiViewController: VC, context: UIViewControllerRepresentableContext<LiveViewController<VC>>) {
            
        }
    }
}
