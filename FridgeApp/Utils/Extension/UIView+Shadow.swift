//
//  UIView+Shadow.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

extension UIView {
    func configShadowWith(color: UIColor) {
        let rect = CGRect(origin: CGPoint(x: (frame.width - frame.width/1.3)/2, y: frame.height),
                          size: CGSize(width: frame.width/1.3, height: frame.height/10))
        layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: frame.width/1.3).cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}
