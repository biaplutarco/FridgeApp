//
//  NSManagedObject+className.swift
//  FridgeApp
//
//  Created by Bia on 29/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation
import CoreData
//
extension NSManagedObject {
    static var className: String {
        return String(describing: self)
    }
}
