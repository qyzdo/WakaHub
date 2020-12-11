//
//  ShortDateFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 11/12/2020.
//

import Charts

final class ShortDateFormatter: IAxisValueFormatter {

    private var values: [String] = []

    init(values: [String]) {
        self.values = values
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {

        let count = self.values.count

        guard let axis = axis, count > 0 else {
            return ""
        }

        let factor = axis.axisMaximum / Double(count)

        let index = Int((value / factor).rounded())

        if index >= 0 && index < count {
            let stringInitialDate = values[index]

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            guard let initialDate = dateFormatter.date(from: stringInitialDate) else {
                return stringInitialDate
            }
            dateFormatter.dateFormat = "d MMM"

            let formattedStringDate = dateFormatter.string(from: initialDate)

            return formattedStringDate
        }

        return ""

    }
}
