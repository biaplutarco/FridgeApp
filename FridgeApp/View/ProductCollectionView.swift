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
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 24
        layout.itemSize = CGSize(width: 100, height: 90)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        configCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCollectionView() {
        backgroundColor = .clear
        alwaysBounceVertical = true
        allowsMultipleSelection = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
}
