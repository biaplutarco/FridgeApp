//
//  ModalView.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalView: UIView {
    lazy var iconCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        addSubviews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(iconCollectionView)
    }
    
    private func configView() {
        backgroundColor = .white
    }
    
    private func configConstraints() {
        
    }
}
