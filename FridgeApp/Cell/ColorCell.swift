//
//  ColorCell.swift
//  FridgeApp
//
//  Created by Bia on 25/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ColorCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            cellDidSelected()
        }
    }
    
    lazy var colorView: UIView = {
        let colorView = UIView()
        colorView.layer.cornerRadius = frame.height/2
        colorView.layer.opacity = 1
        colorView.translatesAutoresizingMaskIntoConstraints = false
        return colorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCellWith(color: UIColor) {
        colorView.backgroundColor = color
        isSelected = false
    }
    
    private func addSubviews() {
        addSubview(colorView)
    }
    
    private func cellDidSelected() {
        if isSelected == true {
            layer.opacity = 0.8
        } else {
            layer.opacity = 0.3
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            colorView.heightAnchor.constraint(equalTo: heightAnchor),
            colorView.widthAnchor.constraint(equalTo: widthAnchor),
            colorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
}
