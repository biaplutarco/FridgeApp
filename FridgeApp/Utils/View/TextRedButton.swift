//
//  TextRedButton.swift
//  FridgeApp
//
//  Created by Bia on 28/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class TextRedButton: UIButton {
    init() {
        super.init(frame: CGRect.zero)
        configButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .actionColor
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
    }
}
