//
//  PieChartsCreator.swift
//  WakaHub
//
//  Created by Oskar Figiel on 21/12/2020.
//

import Foundation
import Charts

enum ChartType {
    case categories
    case languages
    case editors
    case operatingSystems
}

class PieChartCreator {
    var languagesChartView: PieChartView
    var editorsChartView: PieChartView
    var operatingSystemsChartView: PieChartView

    init(languagesChartView: PieChartView, editorsChartView: PieChartView, operatingSystemsChartView: PieChartView) {
        self.languagesChartView = languagesChartView
        self.editorsChartView = editorsChartView
        self.operatingSystemsChartView = operatingSystemsChartView
    }

    func setupPieChart(usageData: [SummaryDataClass], chartType: ChartType) {
        switch chartType {
        case .languages:
            let dictionary = createNameAndUsageDictionary(usageData: usageData, chartType: .languages)

            let usageNames = Array(dictionary.keys)
            let usageTimes = Array(dictionary.values)

            setupPieChartView(dataPoints: usageNames, values: usageTimes, chartView: languagesChartView)

        case .editors:
            let dictionary = createNameAndUsageDictionary(usageData: usageData, chartType: .editors)

            let usageNames = Array(dictionary.keys)
            let usageTimes = Array(dictionary.values)

            setupPieChartView(dataPoints: usageNames, values: usageTimes, chartView: editorsChartView)

        case .operatingSystems:
            let dictionary = createNameAndUsageDictionary(usageData: usageData, chartType: .operatingSystems)

            let usageNames = Array(dictionary.keys)
            let usageTimes = Array(dictionary.values)

            setupPieChartView(dataPoints: usageNames, values: usageTimes, chartView: operatingSystemsChartView)
        default: break
        }
    }

    private func setupPieChartView(dataPoints: [String], values: [Double], chartView: PieChartView) {
        var dataEntries: [ChartDataEntry] = []
        for iterator in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[iterator], label: dataPoints[iterator], data: dataPoints[iterator] as AnyObject)
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = ChartColorTemplates.material()
        pieChartDataSet.yValuePosition = .outsideSlice

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(SecondsToTimeFormatter())
        pieChartData.setValueTextColor(UIColor.label)

        chartView.entryLabelColor = UIColor.label

        chartView.data = pieChartData
        chartView.animate(xAxisDuration: 1)
    }

    private func createNameAndUsageDictionary(usageData: [SummaryDataClass], chartType: ChartType) -> [String: Double] {
        var arrayData = [SummaryUsageTimes]()
        for array in usageData {
            switch chartType {
            case .categories:
                arrayData.append(contentsOf: array.categories)
            case .languages:
                arrayData.append(contentsOf: array.languages)
            case .editors:
                arrayData.append(contentsOf: array.editors)
            case .operatingSystems:
                arrayData.append(contentsOf: array.operatingSystems)
            }
        }

        let groupBy = Dictionary(grouping: arrayData) { $0.name }.reduce(into: [:]) { (name, dict) in

            let (key, value) = dict
            name[key] = value.reduce(0, { $0 + $1.totalSeconds})
        }

        guard let group = groupBy as? [String: Double] else {
            return [String: Double]()
        }

        return group
    }
}
