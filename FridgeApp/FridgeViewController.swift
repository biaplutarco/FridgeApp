//
//  ViewController.swift
//  FridgeApp
//
//  Created by Bia on 23/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class FridgeViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 24
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(SeparatorCell.self, forCellWithReuseIdentifier: "SeparatorCell")
        return collectionView
    }()
    
    lazy var redButton: UIButton = {
        let button = UIButton()
        button.setTitle("Colocar na geladeira", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor.AppColors.lightGray, for: .normal)
        button.backgroundColor = UIColor.AppColors.red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.lightGray
        addSubviews()
        configConstrints()
    }
    
    func configConstrints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85)
            ])
        
        NSLayoutConstraint.activate([
            redButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: view.frame.width * 0.05),
            redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            redButton.heightAnchor.constraint(equalTo: redButton.widthAnchor, multiplier: 0.15)
            ])
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(redButton)
    }
}

extension FridgeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16 //tem que somar pra poder sempre tem a barrinha nos 3 primeiros
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 90)
    }
    
}
