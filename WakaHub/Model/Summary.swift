//
//  Summary.swift
//  WakaHub
//
//  Created by Oskar Figiel on 09/12/2020.
//

import Foundation

struct Summary: Codable {
    let data: [SummaryDataClass]
    let end, start: String
}

// MARK: - Datum
struct SummaryDataClass: Codable {
    let categories: [UsageTimes]
    let dependencies: [UsageTimes]
    let editors: [UsageTimes]
    let grandTotal: GrandTotal
    let languages, machines, operatingSystems, projects: [UsageTimes]
    let range: Range

    enum CodingKeys: String, CodingKey {
        case categories, dependencies, editors
        case grandTotal = "grand_total"
        case languages, machines
        case operatingSystems = "operating_systems"
        case projects, range
    }
}

// MARK: - Category
struct Category: Codable {
    let digital: String
    let hours, minutes: Int
    let name: String
    let percent: Double
    let seconds: Int
    let text: String
    let totalSeconds: Double
    let machineNameID: String?

    enum CodingKeys: String, CodingKey {
        case digital, hours, minutes, name, percent, seconds, text
        case totalSeconds = "total_seconds"
        case machineNameID = "machine_name_id"
    }
}

// MARK: - GrandTotal
struct GrandTotal: Codable {
    let digital: String
    let hours, minutes: Int
    let text: String
    let totalSeconds: Double

    enum CodingKeys: String, CodingKey {
        case digital, hours, minutes, text
        case totalSeconds = "total_seconds"
    }
}

// MARK: - Range
struct Range: Codable {
    let date: String
    let end, start: String
    let text, timezone: String
}
