//
//  ProductCell.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Maionese"
        label.textColor = UIColor.AppColors.darkGray
//        label.backgroundColor = UIColor.AppColors.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "CutMilk")
        imageView.tintColor = UIColor.AppColors.red
        imageView.layer.opacity = 0.08
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.AppColors.darkGray
        label.text = "12 dias"
        label.textAlignment = .right
//        label.backgroundColor = UIColor.AppColors.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.text = "restantes"
        label.textAlignment = .right
        label.textColor = UIColor.AppColors.darkGray
//        label.backgroundColor = UIColor.AppColors.red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func setUpCell(title: String, image: UIImage) {
        titleLabel.text = title
        imageView.image = image
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
//        Shadow Configs
        let rect = CGRect(origin: CGPoint(x: (frame.width - frame.width/1.3)/2, y: frame.height),
                          size: CGSize(width: frame.width/1.3, height: frame.height/10))
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: frame.width/1.3).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        NSLayoutConstraint.activate([
            daysLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            daysLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            daysLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor)
            ])
        
        NSLayoutConstraint.activate([
            bottomLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            bottomLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
    }
}
