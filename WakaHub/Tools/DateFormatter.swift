//
//  DateFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 01/12/2020.
//

import Foundation

extension String {
    public func formatDateWithMonthName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let datetime = formatter.date(from: self)

        guard let date = datetime else {
            return self
        }

        formatter.dateFormat = "MMM dd YYYY"
        return formatter.string(from: date)
    }
}
