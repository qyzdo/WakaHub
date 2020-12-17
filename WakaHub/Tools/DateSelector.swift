//
//  DateSelector.swift
//  WakaHub
//
//  Created by Oskar Figiel on 17/12/2020.
//

import Foundation

enum SelectedDate: String, CaseIterable {
    case today = "Today"
    case yesterday = "Yesterday"
    case sevenDaysAgo = "7 days"
    case fourteenDaysAgo = "14 days"
    case thirtyDaysAgo = "30 days"
}

final class DateSelector {
    private let date = Date()
    private let formatter = DateFormatter()
    private var todayDate: String


    var startDate: String
    var endDate: String

    init() {
        formatter.dateFormat = "yyyy-MM-dd"
        todayDate = formatter.string(from: date)
        self.startDate = todayDate
        self.endDate = todayDate
    }

    func changedDate(selectedDate: SelectedDate) {
        switch selectedDate {
        case .today:
            startDate = todayDate
            endDate = todayDate
        case .yesterday:
            guard let yesterday = date.yesterday else {
                return
            }
            startDate = formatter.string(from: yesterday)
            endDate = formatter.string(from: yesterday)
        case .sevenDaysAgo:
            guard let sevenDaysAgo = date.sevenDaysAgo else {
                return
            }
            startDate = formatter.string(from: sevenDaysAgo)
            endDate = todayDate
        case .fourteenDaysAgo:
            guard let fourteenDaysAgo = date.fourteenDaysAgo else {
                return
            }
            startDate = formatter.string(from: fourteenDaysAgo)
            endDate = todayDate
        case .thirtyDaysAgo:
            guard let thirtyDaysAgo = date.thirtyDaysAgo else {
                return
            }
            startDate = formatter.string(from: thirtyDaysAgo)
            endDate = todayDate
        }
    }
}
