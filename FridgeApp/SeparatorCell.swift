//
//  SeparatorCell.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class SeparatorCell: UICollectionViewCell {
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        backgroundColor = .clear
        
        addSubiviews()
        configConstraints()
    }
    
    private func addSubiviews() {
        addSubview(lineView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
            ])
    }
}
