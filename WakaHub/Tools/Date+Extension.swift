//
//  Date+Extension.swift
//  WakaHub
//
//  Created by Oskar Figiel on 17/12/2020.
//

import Foundation

extension Date {

    private var today: Date {
        return Date()
    }

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }

    var yesterday: Date? {
        return Calendar.current.date(byAdding: .day, value: -1, to: today)
    }

    var sevenDaysAgo: Date? {
        return Calendar.current.date(byAdding: .day, value: -6, to: today)
    }

    var fourteenDaysAgo: Date? {
        return Calendar.current.date(byAdding: .day, value: -13, to: today)
    }

    var thirtyDaysAgo: Date? {
        return Calendar.current.date(byAdding: .day, value: -29, to: today)
    }

}
