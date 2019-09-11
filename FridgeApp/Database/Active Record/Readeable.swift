//
//  Readeable.swift
//  FridgeApp
//
//  Created by Bia on 28/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation

protocol Readable {
    static func all() -> [Self]
    static func find(predicate: NSPredicate) -> [Self]
}
