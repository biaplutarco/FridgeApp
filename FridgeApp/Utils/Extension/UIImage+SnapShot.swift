//
//  UIImage+SnapShot.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

extension UIImage {
    static var snapShot: UIImage {
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
