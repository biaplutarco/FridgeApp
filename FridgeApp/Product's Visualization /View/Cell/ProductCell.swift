//
//  ProductCell.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell, Wiggleable {
    weak var delegate: ProductCellDelegate?
    
    var isWiggling: Bool = false {
        didSet {
            uptadeWiggling()
            showExitButton()
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "CutMilk")
        imageView.layer.opacity = 0.2
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .textColor
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "restantes"
        label.textAlignment = .right
        label.textColor = .textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "exit"), for: .normal)
        button.addTarget(self, action: #selector(exitButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCell()
        addSubviews()
        configConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func exitButtonTapped(_ sender: UIButton) {
        delegate?.didTapButton()
    }
    
    private func showExitButton() {
        if isWiggling == true {
            configExitButton()
        } else {
            exitButton.removeFromSuperview()
        }
    }
    
    private func configExitButton() {
        addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            exitButton.heightAnchor.constraint(equalTo: exitButton.widthAnchor),
            exitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (frame.width/4)*0.2),
            exitButton.bottomAnchor.constraint(equalTo: topAnchor, constant: (frame.width/1.5)*0.2)
            ])
    }
    
    func setUpCellFor(product: Product) {
        if let imageName = product.image, let colorName = product.color,
            let days = product.days?.daysUntil, let title = product.title {
            titleLabel.text = title
            imageView.image = UIImage.init(named: imageName)
            daysLabel.text = String(days)
            imageView.tintColor = UIColor.init(named: colorName)
        }
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(daysLabel)
        addSubview(bottomLabel)
    }
    
    private func configCell() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 10
        configShadowWith(color: UIColor.black)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            daysLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            daysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            daysLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
    }
}
