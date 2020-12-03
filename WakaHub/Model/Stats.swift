//
//  Stats.swift
//  WakaHub
//
//  Created by Oskar Figiel on 02/12/2020.
//

import Foundation

struct Stats: Codable {
    let data: StatsDataClass
}

// MARK: - DataClass
struct StatsDataClass: Codable {
    let bestDay: BestDay
    let categories: [usageTimes]
    let createdAt: String
    let dailyAverage, dailyAverageIncludingOtherLanguage, daysIncludingHolidays, daysMinusHolidays: Int
    let dependencies: [usageTimes]
    let editors: [usageTimes]
    let end: String
    let holidays: Int
    let humanReadableDailyAverage, readableDailyAvgIncludingOtherLanguage, humanReadableTotal, humanReadableTotalIncludingOtherLanguage: String
    let identifier: String
    let isAlreadyUpdating, isCodingActivityVisible, isIncludingToday, isOtherUsageVisible: Bool
    let isStuck, isUpToDate: Bool
    let languages, machines: [usageTimes]
    let modifiedAt: String?
    let operatingSystems: [usageTimes]
    let percentCalculated: Int
    let projects: [usageTimes]
    let range: String
    let start: String
    let status: String
    let timeout: Int
    let timezone: String
    let totalSeconds, totalSecondsIncludingOtherLanguage: Double
    let userID, username: String
    let writesOnly: Bool

    enum CodingKeys: String, CodingKey {
        case bestDay = "best_day"
        case categories
        case createdAt = "created_at"
        case dailyAverage = "daily_average"
        case dailyAverageIncludingOtherLanguage = "daily_average_including_other_language"
        case daysIncludingHolidays = "days_including_holidays"
        case daysMinusHolidays = "days_minus_holidays"
        case dependencies, editors, end, holidays
        case humanReadableDailyAverage = "human_readable_daily_average"
        case readableDailyAvgIncludingOtherLanguage = "human_readable_daily_average_including_other_language"
        case humanReadableTotal = "human_readable_total"
        case humanReadableTotalIncludingOtherLanguage = "human_readable_total_including_other_language"
        case identifier = "id"
        case isAlreadyUpdating = "is_already_updating"
        case isCodingActivityVisible = "is_coding_activity_visible"
        case isIncludingToday = "is_including_today"
        case isOtherUsageVisible = "is_other_usage_visible"
        case isStuck = "is_stuck"
        case isUpToDate = "is_up_to_date"
        case languages, machines
        case modifiedAt = "modified_at"
        case operatingSystems = "operating_systems"
        case percentCalculated = "percent_calculated"
        case projects, range, start, status, timeout, timezone
        case totalSeconds = "total_seconds"
        case totalSecondsIncludingOtherLanguage = "total_seconds_including_other_language"
        case userID = "user_id"
        case username
        case writesOnly = "writes_only"
    }
}

// MARK: - BestDay
struct BestDay: Codable {
    let createdAt: String
    let date, identifier: String
    let modifiedAt: String?
    let text: String
    let totalSeconds: Double

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case date
        case identifier = "id"
        case modifiedAt = "modified_at"
        case text
        case totalSeconds = "total_seconds"
    }
}

// MARK: - Category
struct usageTimes: Codable {
    let digital: String
    let hours, minutes: Int
    let name: String
    let percent: Double
    let text: String
    let totalSeconds: Double
    let machine: Machine?

    enum CodingKeys: String, CodingKey {
        case digital, hours, minutes, name, percent, text
        case totalSeconds = "total_seconds"
        case machine
    }
}

// MARK: - Machine
struct Machine: Codable {
    let createdAt: String
    let identifier, ipAdress: String
    let lastSeenAt: String
    let name, value: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case identifier = "id"
        case lastSeenAt = "last_seen_at"
        case ipAdress = "ip"
        case name, value
    }
}
