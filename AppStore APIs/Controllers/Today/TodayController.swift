//
//  TodayController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 26/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class TodayController: BaseListController {
    
    // MARK: - Properties
    
    let viewModel: TodayViewModel
    var appFullScreeController: AppFullScreenController?
    
    // MARK: - Lifecycle
    
    init(viewModel: TodayViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Helpers
    
    private func configure() {
        navigationController?.isNavigationBarHidden = true
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 32, left: 32, bottom: 32, right: 32)
    }
    
    @objc private func handleRemoveRedView(controller: UIViewController) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.appFullScreeController?.tableView.scrollToRow(at: [0,0], at: .top, animated: true)
            guard let startingFrame = self.viewModel.startingFrame else { return }
            self.viewModel.topConstraint?.constant = startingFrame.origin.y
            self.viewModel.leadingConstraint?.constant = startingFrame.origin.x
            self.viewModel.widthConstraint?.constant = startingFrame.width
            self.viewModel.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
            if let tabBarFrame = self.tabBarController?.tabBar.frame {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
            }
            
        }, completion: { _ in
            controller.view.removeFromSuperview()
            self.appFullScreeController?.removeFromParent()
        })
    }
    
    private func showFullScreenController(indexPath: IndexPath) {
        let fullScreenController = AppFullScreenController(style: .grouped)
        fullScreenController.delelgate = self
        
        guard let cardView = fullScreenController.view else { return }
        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)
        addChild(fullScreenController)
        appFullScreeController = fullScreenController
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        viewModel.startingFrame = startingFrame
        cardView.frame = viewModel.startingFrame ?? .zero
        cardView.layer.cornerRadius = 16
        
        viewModel.topConstraint = cardView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        viewModel.leadingConstraint = cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        viewModel.widthConstraint = cardView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        viewModel.heightConstraint = cardView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [viewModel.topConstraint, viewModel.leadingConstraint, viewModel.widthConstraint, viewModel.heightConstraint].forEach { $0?.isActive = true}
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.viewModel.topConstraint?.constant = 0
            self.viewModel.leadingConstraint?.constant = 0
            self.viewModel.widthConstraint?.constant = self.view.frame.width
            self.viewModel.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
        }, completion: nil)
    }
}

// MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension TodayController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.reuseIdentifier, for: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showFullScreenController(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TodayController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32    }
}

// MARK: - DismissDelegate

extension TodayController: DismissDelegate {
    func onDismissButtonTapped(controller: UIViewController) {
        handleRemoveRedView(controller: controller)
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct TodayControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = TodayViewModel()
        
        let controller = TodayController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}
