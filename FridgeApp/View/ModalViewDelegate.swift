//
//  ModalViewDelegate.swift
//  FridgeApp
//
//  Created by Bia on 29/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

protocol ModalViewDelegate: class {
    func saveProductWith(title: String, expiryDate: String, colorName: String, andIconName: String)
}
