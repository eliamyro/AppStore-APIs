//
//  AppsHorizontalController.swift
//  AppStore APIs
//
//  Created by Elias Myronidis on 13/4/20.
//  Copyright © 2020 Elias Myronidis. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    // MARK: - Properties
    
    let viewModel: AppsHorizontalViewModel
    
    var didSelectHandler: ((FeedResult) -> ())?
    
    // MARK: - Lifecycle
    
    init(viewModel: AppsHorizontalViewModel) {
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
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 12, left: 16, bottom: 12, right: 16)
    }
}

    // MARK: - UICollectionViewDatasource - UICollectionViewDelegate

extension AppsHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.apps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.reuseIdentifier, for: indexPath) as! AppRowCell
        cell.app = viewModel.apps[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = viewModel.apps[indexPath.item]
        didSelectHandler?(app)
    }
}

    // MARK: - UICollectionViewDelegateFlowLayout

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 48
        let height = (view.frame.height - 24 - 20) / 3
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
