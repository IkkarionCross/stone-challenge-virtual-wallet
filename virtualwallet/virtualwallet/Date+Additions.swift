//
//  Date+Additions.swift
//  virtualwallet
//
//  Created by victor-mac on 17/02/18.
//  Copyright © 2018 victor. All rights reserved.
//

import Foundation

extension Date {
    func formattedWith(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self as Date)
    }

    func add(days: Int) -> Date? {
        var component = DateComponents()
        component.day = days
        return Calendar.current.date(byAdding: component, to: self)
    }

    func lastFriday() -> Date? {
        let calendar = Calendar.current
        let weekDay = calendar.component(Calendar.Component.weekday, from: self)
        let goBackDays: Int = (weekDay + 1) * -1
        return self.add(days: goBackDays)
    }
}
