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
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.AppColors.red
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
