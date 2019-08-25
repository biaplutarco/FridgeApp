//
//  ModalView.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ModalView: UIView {
//    lazy var flowLayout: UICollectionViewFlowLayout = {
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 16
//        return flowLayout
//    }()
    
    lazy var iconCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 0
        collectionView.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        return collectionView
    }()
    
    lazy var colorCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.tag = 1
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: "ColorCell")
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
        addSubview(colorCollectionView)
    }
    
    private func configView() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            iconCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            iconCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            iconCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
            ])
        
        NSLayoutConstraint.activate([
            colorCollectionView.topAnchor.constraint(equalTo: iconCollectionView.bottomAnchor),
            colorCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            colorCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            colorCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
            ])
    }
}

extension ModalView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as? IconCell else { return UICollectionViewCell() }
            cell.setUpCellWith(image: #imageLiteral(resourceName: "Meat"))
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorCell else { return UICollectionViewCell() }
            cell.setUpCellWith(color: UIColor.AppColors.red!)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if collectionView.tag == 0 {
            collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            print("a")
        } else {
            print("b")
            collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform.identity
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: iconCollectionView.frame.height/1.2, height: iconCollectionView.frame.height/1.2)
        } else {
            return CGSize(width: colorCollectionView.frame.height/2, height: colorCollectionView.frame.height/2)
        }
    }
}
