//
//  ViewController.swift
//  FridgeApp
//
//  Created by Bia on 23/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit
import CoreData

class ProductsViewController: UIViewController {
    weak var delegate: ProductsViewControllerDelegate?
    
    lazy var products: [Product] = {
        let products = Product.all()
        return products
    }()

    lazy var collectionView: ProductCollectionView = {
        let collectionView = ProductCollectionView(registerCellOfType: ProductCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    lazy var redButton: TextRedButton = {
        let button = TextRedButton()
        button.setTitle("Colocar na geladeira", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
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
        view.backgroundColor = .backgroundColor
//        products.forEach { $0.destroy() }
        addSubviews()
        configConstrints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        blurredView.removeFromSuperview()
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        navigationController?.view.addSubview(blurredView)
        delegate?.presentModalWith(backgroundImage: screenShotMethod())
    }
    
    func screenShotMethod() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        return UIImage.snapShot
    }
    
    func insertProduct(_ product: Product) {
        products.insert(product, at: 0)
    }
    
    func insertCollectionItem() {
        collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
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

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count //tem que somar pra poder sempre tem a barrinha nos 3 primeiros
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(of: ProductCell.self, forIndexPath: indexPath)
        cell.setUpCellFor(product: products[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ProductCell else { return }
        cell.isWiggling.toggle()
    }
}
