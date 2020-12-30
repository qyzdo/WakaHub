//
//  CategoryChartView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 21/12/2020.
//

import Foundation
import Charts

class CategoryChartCreator {
    var categoryChartView: BarChartView

    init(categoryChartView: BarChartView) {
        self.categoryChartView = categoryChartView
    }

    func setupCategoryChart(usageData: [SummaryDataClass]) {
        var dataPoints = [String]()
        for points in usageData {
            let date = points.range.date
            dataPoints.append(date)
        }

        let chartsData = createArrayWithCustomCategoryData(data: usageData)
        setupCategoriesChartLegend()
        setupCategoriesChartView(dataPoints: dataPoints)

        let dataSets = setupDataSets(data: chartsData, dataPoints: dataPoints)
        let chartData = BarChartData(dataSets: dataSets)

        let groupSpace = 0.1
        let barSpace = 0.05
        let barWidth = 0.25

        let groupCount = dataPoints.count
        let startValue = 0.0

        chartData.barWidth = barWidth
        categoryChartView.xAxis.axisMinimum = startValue
        let groupWidth = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        categoryChartView.xAxis.axisMaximum = startValue + groupWidth * Double(groupCount)

        chartData.groupBars(fromX: startValue, groupSpace: groupSpace, barSpace: barSpace)

        categoryChartView.data = chartData
    }

    private func createArrayWithCustomCategoryData(data: [SummaryDataClass]) -> [CustomCategoryData] {
        var arrayOfData = [CustomCategoryData]()

        for array in data {
            let date = array.range.date
            if array.categories.count > 0 {
                let namesArray = array.categories.map { $0.name }
                if !namesArray.contains("Coding") {
                    let buildingEmptyData = CustomCategoryData(name: "Building", time: 0, date: date)
                    arrayOfData.append(buildingEmptyData)
                }

                if !namesArray.contains("Building") {
                    let buildingEmptyData = CustomCategoryData(name: "Building", time: 0, date: date)
                    arrayOfData.append(buildingEmptyData)
                }

                if !namesArray.contains("Debugging") {
                    let debuggingEmptyData = CustomCategoryData(name: "Debugging", time: 0, date: date)
                    arrayOfData.append(debuggingEmptyData)
                }
                for object in array.categories {
                    let testObject = CustomCategoryData(name: object.name, time: object.totalSeconds, date: date)
                    arrayOfData.append(testObject)
                }
            } else {
                let buildingEmptyData = CustomCategoryData(name: "Building", time: 0, date: date)
                let codingEmptyData = CustomCategoryData(name: "Coding", time: 0, date: date)
                let debuggingEmptyData = CustomCategoryData(name: "Debugging", time: 0, date: date)

                arrayOfData.append(buildingEmptyData)
                arrayOfData.append(codingEmptyData)
                arrayOfData.append(debuggingEmptyData)
            }
        }

        return arrayOfData
    }

    private func setupCategoriesChartLegend() {
            let legend = self.categoryChartView.legend
            legend.enabled = true
            legend.horizontalAlignment = .right
            legend.verticalAlignment = .top
            legend.orientation = .vertical
            legend.drawInside = true
            legend.yOffset = 10.0
            legend.xOffset = 10.0
            legend.yEntrySpace = 0.0
    }

    private func setupDataSets(data: [CustomCategoryData], dataPoints: [String]) -> [BarChartDataSet] {
        let coding = data.filter { $0.name == "Coding"}.map { $0.time}
        let building = data.filter { $0.name == "Building"}.map { $0.time}
        let debugging = data.filter { $0.name == "Debugging"}.map { $0.time}

        var codingDataEntries: [BarChartDataEntry] = []
        var buildingDataEntries: [BarChartDataEntry] = []
        var debuggingDataEntries: [BarChartDataEntry] = []

        for iterator in 0..<dataPoints.count {

            var codingY = 0.0
            if coding.indices.contains(iterator) {
                codingY = coding[iterator]
            }

            let codingDataEntry = BarChartDataEntry(x: Double(iterator), y: codingY)
            codingDataEntries.append(codingDataEntry)

            var buildingY = 0.0
            if building.indices.contains(iterator) {
                buildingY = building[iterator]
            }
            let buildingDataEntry = BarChartDataEntry(x: Double(iterator), y: buildingY)
            buildingDataEntries.append(buildingDataEntry)

            var debuggingY = 0.0
            if debugging.indices.contains(iterator) {
                debuggingY = debugging[iterator]
            }
            let debuggingDataEntry = BarChartDataEntry(x: Double(iterator), y: debuggingY)
            debuggingDataEntries.append(debuggingDataEntry)
        }

        let codingDataSet = BarChartDataSet(entries: codingDataEntries, label: "Coding")
        codingDataSet.valueFormatter = SecondsToTimeFormatter()
        codingDataSet.highlightEnabled = false

        let buildingDataSet = BarChartDataSet(entries: buildingDataEntries, label: "Building")
        buildingDataSet.valueFormatter = SecondsToTimeFormatter()
        buildingDataSet.highlightEnabled = false

        let debuggingDataSet = BarChartDataSet(entries: debuggingDataEntries, label: "Debugging")
        debuggingDataSet.valueFormatter = SecondsToTimeFormatter()
        debuggingDataSet.highlightEnabled = false

        let dataSets = [codingDataSet, buildingDataSet, debuggingDataSet]
        codingDataSet.colors = [UIColor.systemBlue]
        buildingDataSet.colors = [UIColor.systemYellow]
        debuggingDataSet.colors = [ UIColor.green]

        return dataSets
    }

    private func setupCategoriesChartView(dataPoints: [String]) {
        let xaxis = categoryChartView.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = ShortDateFormatter(values: dataPoints)
        xaxis.granularity = 1

        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1

        let yaxis = categoryChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.enabled = false

        categoryChartView.rightAxis.enabled = false

        categoryChartView.doubleTapToZoomEnabled = false

        categoryChartView.animate(yAxisDuration: 1)
    }
}
