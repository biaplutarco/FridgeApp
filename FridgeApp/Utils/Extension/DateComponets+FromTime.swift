//
//  DateComponets+FromTime.swift
//  FridgeApp
//
//  Created by Bia on 10/09/19.
//  Copyright © 2019 akhaten. All rights reserved.
//

import Foundation

extension DateComponents {
    func fromTime(hour: Int, minute: Int) -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        guard let today = components.day else { fatalError("error no today") }
        let dateComponets = DateComponents(calendar: Calendar.current, year: components.year, month: components.month,
                                           day: today, hour: hour, minute: minute)
        return dateComponets
    }
}
