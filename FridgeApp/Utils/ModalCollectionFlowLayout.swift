//
//  CustomFlowLayout.swift
//  FridgeApp
//
//  Created by Bia on 28/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalCollectionFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
        sectionInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
