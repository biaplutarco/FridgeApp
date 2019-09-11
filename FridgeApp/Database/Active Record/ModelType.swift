//
//  ModelType.swift
//  FridgeApp
//
//  Created by Bia on 28/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation

protocol ModelType: ActiveRecordType {
    associatedtype Context
    static var context: Self.Context { get }
}
