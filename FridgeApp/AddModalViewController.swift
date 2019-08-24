//
//  AddProductView.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class AddModalViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    lazy var iconCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configView()
    }
    
    private func addSubviews() {
        view.addSubview(iconCollectionView)
    }
    
    private func configView() {
        
    }
    
    private func configConstraints() {
        
    }
}
