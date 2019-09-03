//
//  UIColors + AppColors.swift
//  FridgeApp
//
//  Created by Bia on 24/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

extension UIColor {
    open class var backgroundColor: UIColor {
        return UIColor.init(named: "BackgroundColor") ?? UIColor.black
    }
    
    open class var actionColor: UIColor {
        return UIColor.init(named: "ActionColor") ?? UIColor.black
    }
    
    open class var textColor: UIColor {
        return UIColor.init(named: "TextColor") ?? UIColor.black
    }
}
