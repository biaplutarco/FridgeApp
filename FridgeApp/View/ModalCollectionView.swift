//
//  ModalCollectionView.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalCollectionView: UICollectionView {
    convenience init<T: UICollectionViewCell>(registerCellOfType: T.Type, isStatic: Bool) {
        self.init()
        registerCell(of: registerCellOfType)
        configStaticCollection(isStatic: isStatic)
    }
    
    private init() {
        super.init(frame: CGRect.zero, collectionViewLayout: ModalCollectionFlowLayout())
        configCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCollectionView() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configStaticCollection(isStatic: Bool) {
        if isStatic == true {
            isScrollEnabled = false
        } else {
            isScrollEnabled = true
            alwaysBounceHorizontal = true
            showsHorizontalScrollIndicator = false
        }
    }
}
