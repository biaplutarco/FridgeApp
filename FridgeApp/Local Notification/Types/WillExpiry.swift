//
//  WillExpiry.swift
//  FridgeApp
//
//  Created by Bia on 10/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import UIKit

class WillExpiry: Notificable {
    var productTitle: String
    var datetime: DateComponents
    var title: String = "Importante!"
    var body: String
    
    init(productTitle: String, datetime: DateComponents) {
        self.productTitle = productTitle
        self.datetime = datetime
        self.body = "\(productTitle) vai vencer amanhã! 🤔"
    }
}
