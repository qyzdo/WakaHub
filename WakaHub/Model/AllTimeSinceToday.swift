//
//  AllTimeSinceToday.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/12/2020.
//

import Foundation

struct AllTimeSinceToday: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let isUpToDate: Bool
    let text: String
    let totalSeconds: Double

    enum CodingKeys: String, CodingKey {
        case isUpToDate = "is_up_to_date"
        case text
        case totalSeconds = "total_seconds"
    }
}
