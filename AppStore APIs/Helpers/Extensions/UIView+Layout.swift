//
//  UIView+Layout.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 8/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

extension UIView {
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
       translatesAutoresizingMaskIntoConstraints = false
       
       if let superview = superview {
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right).isActive = true
       }
   }
   
   func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, margin: UIEdgeInsets = .zero, size: CGSize = .zero) {
       translatesAutoresizingMaskIntoConstraints = false
       
       _ = anchorWithReturnAnchors(top: top, leading: leading, bottom: bottom, trailing: trailing, margin: margin, size: size)
   }
   
   func anchorWithReturnAnchors(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, margin: UIEdgeInsets = .zero, size: CGSize = .zero) -> [NSLayoutConstraint] {
       var anchors = [NSLayoutConstraint]()
       
       if let top = top {
           anchors.append(topAnchor.constraint(equalTo: top, constant: margin.top))
       }
       
       if let leading = leading {
           anchors.append(leadingAnchor.constraint(equalTo: leading, constant: margin.left))
       }
       
       if let bottom = bottom {
           anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -margin.bottom))
       }
       
       if let trailing = trailing {
           anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -margin.right))
       }
       
       if size.width != 0 {
           anchors.append(widthAnchor.constraint(equalToConstant: size.width))
       }
       
       if size.height != 0 {
           anchors.append(heightAnchor.constraint(equalToConstant: size.height))
       }
       
       anchors.forEach({$0.isActive = true})
       
       return anchors
   }
   
   func anchorHW(height: NSLayoutDimension? = nil, width: NSLayoutDimension? = nil, hMultiplier: CGFloat = 1, wMultiplier: CGFloat = 1) {
       translatesAutoresizingMaskIntoConstraints = false
       
       if let height = height {
           heightAnchor.constraint(equalTo: height, multiplier: hMultiplier).isActive = true
       }
       
       if let width = width {
           widthAnchor.constraint(equalTo: width, multiplier: wMultiplier).isActive = true
       }
   }
   
   func anchorHeightWidth(height: NSLayoutDimension? = nil, width: NSLayoutDimension? = nil, multiplier: CGFloat = 1) {
       translatesAutoresizingMaskIntoConstraints = false
       
       if let height = height {
           heightAnchor.constraint(equalTo: height, multiplier: multiplier).isActive = true
       }
       
       if let width = width {
           widthAnchor.constraint(equalTo: width, multiplier: multiplier).isActive = true
       }
   }
   
   func anchorHeightWidth(heightConstant: CGFloat? = nil, widthConstant: CGFloat? = nil) {
       translatesAutoresizingMaskIntoConstraints = false
       
       if let height = heightConstant {
           heightAnchor.constraint(equalToConstant: height).isActive = true
       }
       
       if let width = widthConstant {
           widthAnchor.constraint(equalToConstant: width).isActive = true
       }
   }
   
   func anchorCenterXToView(view: UIView, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
   }
   
   func anchorCenterYToView(view: UIView, constant: CGFloat = 0) {
       translatesAutoresizingMaskIntoConstraints = false
       centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
   }
   
   func anchorCenterToView(view: UIView) {
       anchorCenterXToView(view: view)
       anchorCenterYToView(view: view)
   }
}
