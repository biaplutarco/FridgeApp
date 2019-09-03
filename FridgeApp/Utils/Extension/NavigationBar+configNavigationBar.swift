//
//  NavigationBar.swift
//  FridgeApp
//
//  Created by Bia on 02/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func configNavigationBar() {
        prefersLargeTitles = true
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColor]
        barTintColor = .backgroundColor
        shadowImage = UIImage()
    }
}
