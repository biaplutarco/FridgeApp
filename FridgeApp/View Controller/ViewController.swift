//
//  ViewController.swift
//  FridgeApp
//
//  Created by Bia on 23/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    lazy var products: [Product] = {
        let products = Product.all()
        return products
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 24
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(SeparatorCell.self, forCellWithReuseIdentifier: "SeparatorCell")
        return collectionView
    }()
    
    lazy var redButton: TextRedButton = {
        let button = TextRedButton()
        button.setTitle("Colocar na geladeira", for: .normal)
        button.addTarget(self, action: #selector(goToModal(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var blurredView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.frame
        visualEffectView.effect = UIBlurEffect(style: .dark)
        view.bringSubviewToFront(visualEffectView)
        return visualEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.lightGray
        
        products.forEach { $0.destroy() }

        addSubviews()
        configConstrints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        blurredView.removeFromSuperview()
    }
    
    @objc func goToModal(_ sender: UIButton) {
        navigationController?.view.addSubview(blurredView)
        coordinator?.goToModalVC(snapShot: screenShotMethod())
    }
    
    func screenShotMethod() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
    
    private func configConstrints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width * 0.03),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
            ])
        
        NSLayoutConstraint.activate([
            redButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: view.frame.width * 0.08),
            redButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.width * 0.08),
            redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.9 - 12),
            redButton.heightAnchor.constraint(equalTo: redButton.widthAnchor, multiplier: 0.15)
            ])
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(redButton)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count //tem que somar pra poder sempre tem a barrinha nos 3 primeiros
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else { return UICollectionViewCell() }
        
        let product = products[indexPath.row]
        guard let title = product.title, let imageName = product.cutImage,
            let colorName = product.color, let days = product.days else { return UICollectionViewCell() }
            cell.setUpCell(title: title, imageName: imageName, colorName: colorName, days: days)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
    }
}
