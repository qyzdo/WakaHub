//
//  DailyAverageChart.swift
//  WakaHub
//
//  Created by Oskar Figiel on 29/12/2020.
//
import Charts

class DailyAverageChart {
    var dailyAverageChartView: PieChartView
    var dailyAverageLabel: UILabel

    init(dailyAverageChartView: PieChartView, dailyAverageLabel: UILabel) {
        self.dailyAverageChartView = dailyAverageChartView
        self.dailyAverageLabel = dailyAverageLabel
    }

    func setupChart(usageData: [SummaryDataClass]) {
        var dataPoints = [String]()
        var values = [Double]()
        let dailyAverage = extractDailyAverageSeconds(usageData: usageData)
        guard let total = usageData.last?.grandTotal.totalSeconds else {
            return
        }
        if total >= dailyAverage {
            values = [total]
            dataPoints = ["Today"]
        } else {
            values = [total, dailyAverage - total]
            dataPoints = ["Today", "Daily Average"]
        }
        var dataEntries: [ChartDataEntry] = []
        for iterator in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[iterator], label: dataPoints[iterator], data: dataPoints[iterator] as AnyObject)
            dataEntries.append(dataEntry)
        }

        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = ChartColorTemplates.material()
        pieChartDataSet.yValuePosition = .insideSlice

        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(SecondsToTimeFormatter())
        pieChartData.setValueTextColor(UIColor.label)

        dailyAverageChartView.entryLabelColor = UIColor.label

        dailyAverageChartView.data = pieChartData
        dailyAverageChartView.animate(xAxisDuration: 1)
        dailyAverageChartView.legend.enabled = false

        dailyAverageLabel.text = "Daily Average " + dailyAverage.secondsToTime()

    }

    private func extractDailyAverageSeconds(usageData: [SummaryDataClass]) -> Double {
        let timeArray = usageData.map { $0.grandTotal.totalSeconds }
        let timeArrayWithoutEmptyValues = timeArray.filter { $0 > 0}
        let timesSum = timeArrayWithoutEmptyValues.reduce(0, +)
        print(timesSum)
        var dailyAverage = timesSum / Double(timeArrayWithoutEmptyValues.count)
        if dailyAverage.isNaN {
            dailyAverage = 0.0
        }
        print("-------")
        return dailyAverage
    }
}
