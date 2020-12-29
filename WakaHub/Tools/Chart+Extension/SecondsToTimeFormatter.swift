//
//  SecondsToTimeFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 10/12/2020.
//

import Charts

class SecondsToTimeFormatter: IValueFormatter {
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return value.secondsToTime()
    }
}
