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
    
    @objc private func handleRemoveRedView(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            gesture.view?.frame = self.viewModel.startingFrame ?? .zero
        }, completion: { _ in
            gesture.view?.removeFromSuperview()
        })
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
        let redView = UIView()
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveRedView)))
        redView.backgroundColor = .red
        view.addSubview(redView)
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        print(cell.frame)
        
        viewModel.startingFrame = cell.superview?.convert(cell.frame, to: nil)
        redView.frame = viewModel.startingFrame ?? .zero
        redView.layer.cornerRadius = 16
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            redView.frame = self.view.frame
        }, completion: nil)
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

// MARK: - PreviewProvider

import SwiftUI

struct TodayControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = TodayViewModel()
        
        let controller = TodayController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all)
    }
}
