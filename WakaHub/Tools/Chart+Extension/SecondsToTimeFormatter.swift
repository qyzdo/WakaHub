//
//  SecondsToTimeFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 10/12/2020.
//

import Charts

class SecondsToTimeFormatter: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated

        guard let formattedString = formatter.string(from: value) else {
            return "\(value)"
        }
        return formattedString
    }
}
