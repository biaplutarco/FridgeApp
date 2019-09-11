//
//  Notification.swift
//  FridgeApp
//
//  Created by Bia on 06/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation

protocol Notificable {
    var title: String { get set }
    var body: String { get set }
    var productTitle: String { get set }
    var datetime: DateComponents { get set }
}
