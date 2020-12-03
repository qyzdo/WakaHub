//
//  PercentFormatter.swift
//  WakaHub
//
//  Created by Oskar Figiel on 03/12/2020.
//

import Foundation
import Charts

class ChartsFormatterPercent: IValueFormatter {
func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
    return "\(value)%"
}}
