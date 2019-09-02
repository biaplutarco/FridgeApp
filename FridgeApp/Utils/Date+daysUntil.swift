//
//  Date+daysSinceNow.swift
//  FridgeApp
//
//  Created by Bia on 30/08/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation

extension Date {
    var daysUntil: Int {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMMM dd, yyyy"
        guard let days = Calendar.current.dateComponents([.day], from: now, to: self).day else { return Int() }
        
        return days
    }
}
