//
//  DailyAverageChart.swift
//  WakaHub
//
//  Created by Oskar Figiel on 29/12/2020.
//
import Charts

class DailyAverageChart {
    var dailyAverageView: DailyAverageView
    var dailyAverageChartView: PieChartView
    var dailyAverageTimeLabel: UILabel
    var lastDayTimeLabel: UILabel
    var percentLabel: UILabel


    init(dailyAverageView: DailyAverageView) {
        self.dailyAverageView = dailyAverageView
        self.dailyAverageChartView = dailyAverageView.dailyAverageChart
        self.dailyAverageTimeLabel = dailyAverageView.dailyAverageTimeLabel
        self.lastDayTimeLabel = dailyAverageView.lastDayTimeLabel
        self.percentLabel = dailyAverageView.percentLabel
    }

    func setupChart(usageData: [SummaryDataClass]) {
        var dataPoints = [String]()
        var values = [Double]()
        let dailyAverage = extractDailyAverageSeconds(usageData: usageData)
        guard let lastDay = usageData.last else {
            return
        }
        let total = lastDay.grandTotal.totalSeconds

        let lastDayDate = lastDay.range.date.formatDateWithWeekDayName()

        if total >= dailyAverage {
            values = [total]
            dataPoints = [lastDayDate]
        } else {
            values = [total, dailyAverage - total]
            dataPoints = [lastDayDate, "Left to Daily Average"]
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

        dailyAverageTimeLabel.attributedText = "Daily Average".createTwoPartsAttributedString(secondPart: dailyAverage.secondsToTime())
        lastDayTimeLabel.attributedText = lastDayDate.createTwoPartsAttributedString(secondPart: total.secondsToTime())
        let percent = Int(((total/dailyAverage*100) - 100).rounded())
        if percent >= 0 {
            percentLabel.attributedText = (String(percent) + "% Increase").setupLabelWithImage(imageName: "arrow.up")
        } else {
            percentLabel.attributedText = (String(abs(percent)) + "% Decrease").setupLabelWithImage(imageName: "arrow.down")
        }
    }

    private func extractDailyAverageSeconds(usageData: [SummaryDataClass]) -> Double {
        let timeArray = usageData.map { $0.grandTotal.totalSeconds }
        let timeArrayWithoutEmptyValues = timeArray.filter { $0 > 0}
        let timesSum = timeArrayWithoutEmptyValues.reduce(0, +)
        var dailyAverage = timesSum / Double(timeArrayWithoutEmptyValues.count)
        if dailyAverage.isNaN {
            dailyAverage = 0.0
        }
        return dailyAverage
    }
}
