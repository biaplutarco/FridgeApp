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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "IconCell")
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
        layer.cornerRadius = 10
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            iconCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8),
            iconCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
            ])
    }
}

extension ModalView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath)
        cell.backgroundColor = UIColor.AppColors.red
        return cell
    }
    
}
