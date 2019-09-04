//
//  ProductCollectionView.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ProductCollectionView: UICollectionView {
    convenience init<T: UICollectionViewCell>(registerCellOfType: T.Type) {
        self.init()
        registerCell(of: registerCellOfType)
    }
    
    private init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 24
        super.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        configCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCollectionView() {
        backgroundColor = .clear
        alwaysBounceVertical = true
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}
