//
//  IconCell.swift
//  FridgeApp
//
//  Created by Bia on 25/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class IconCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            cellDidSelected()
        }
    }
    
    lazy var selectedColor: UIColor = {
        let color = UIColor()
        return color
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.layer.opacity = 1
        imageView.tintColor = UIColor.lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellWith(image: UIImage, andSelectedColor: UIColor) {
        imageView.image = image
        selectedColor = andSelectedColor
    }
    
    private func addSubviews() {
        addSubview(imageView)
    }
    
    private func cellDidSelected() {
        if isSelected == true {
            imageView.tintColor = selectedColor
        } else {
            imageView.tintColor = UIColor.lightGray
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
