//
//  TimeFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 29/12/2020.
//

import Foundation

extension Double {
    func secondsToTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated

        guard let formattedString = formatter.string(from: self) else {
            return "\(self)"
        }
        return formattedString
    }
}
