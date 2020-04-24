//
//  ReviewsController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 24/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingController {
    
    // MARK: - Properties
    
    let viewModel: ReviewsViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: ReviewsViewModel) {
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
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    // MARK: - Constraints
    
    
}

// MARK: UICollectionViewDatasource - UICollectionViewDelegate

extension ReviewsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.reviews?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        cell.review = viewModel.reviews?[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 32, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: - PreviewProvider

import SwiftUI

struct ReviewsControllerPreview: PreviewProvider {
    static var previews: some View {
        let viewModel = ReviewsViewModel()
        
        let controller = ReviewsController(viewModel: viewModel)
        return controller.liveView.edgesIgnoringSafeArea(.all).previewLayout(.fixed(width: 500, height: 300))
    }
}

