//
//  StatsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts

final class StatsVC: UIViewController {
    var barChartView: BarChartView!

    override func loadView() {
        let view = StatsView()
        self.view = view
    }

    private var statsView: StatsView {
        // swiftlint:disable:next force_cast
        return view as! StatsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        barChartView = statsView.categoryChart

        setupNavbar()
        loadData()
    }

    private func setupNavbar() {
        DispatchQueue.main.async {
            self.navigationItem.title = "Stats"
        }
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .summaries(startDate: "2020-12-04", endDate: "2020-12-10"), decodeType: Summary.self) { result in
            switch result {
            case .success(let response):
                //print(response)
                //                self.setupEditors(response: response)
                self.setupCategoryChart(data: response.data)
                DispatchQueue.main.async {
                    self.statsView.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")
            }
        }
    }

    private func setupCategoryChart(data: [SummaryDataClass]) {
        var dataPoints = [String]()
        for points in data {
            let date = points.range.date
            dataPoints.append(date)
        }

        let chartsData = createArrayWithCustomCategoryData(data: data)

        setupLegend()

        let xaxis = barChartView.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        xaxis.granularity = 1

        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1

        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.enabled = false

        barChartView.rightAxis.enabled = false

        let dataSets = setupDataSets(data: chartsData, dataPoints: dataPoints)
        let chartData = BarChartData(dataSets: dataSets)

        let groupSpace = 0.1
        let barSpace = 0.05
        let barWidth = 0.25

        let groupCount = dataPoints.count
        let startValue = 0.0

        chartData.barWidth = barWidth
        barChartView.xAxis.axisMinimum = startValue
        let groupWidth = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(groupWidth)")
        barChartView.xAxis.axisMaximum = startValue + groupWidth * Double(groupCount)

        chartData.groupBars(fromX: startValue, groupSpace: groupSpace, barSpace: barSpace)

        barChartView.data = chartData
        barChartView.animate(yAxisDuration: 1)
    }

    private func createArrayWithCustomCategoryData(data: [SummaryDataClass]) -> [CustomCategoryData] {
        var arrayOfData = [CustomCategoryData]()

        for array in data {
            let date = array.range.date
            if array.categories.count > 0 {
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

    private func setupLegend() {
        DispatchQueue.main.async {
            let legend = self.barChartView.legend
            legend.enabled = true
            legend.horizontalAlignment = .right
            legend.verticalAlignment = .top
            legend.orientation = .vertical
            legend.drawInside = true
            legend.yOffset = 10.0
            legend.xOffset = 10.0
            legend.yEntrySpace = 0.0
        }
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

        let buildingDataSet = BarChartDataSet(entries: buildingDataEntries, label: "Building")
        buildingDataSet.valueFormatter = SecondsToTimeFormatter()

        let debuggingDataSet = BarChartDataSet(entries: debuggingDataEntries, label: "Debugging")
        debuggingDataSet.valueFormatter = SecondsToTimeFormatter()

        let dataSets = [codingDataSet, buildingDataSet, debuggingDataSet]
        codingDataSet.colors = [UIColor.systemBlue]
        buildingDataSet.colors = [UIColor.systemYellow]
        debuggingDataSet.colors = [ UIColor.green]

        return dataSets
    }

    private func setupEditors(response: Summary) {
        var megaArray = 0.00
        for array in response.data {
            let array =  array.editors.filter { $0.name == "Xcode" }
            for data in array {
                print(data)
                megaArray += data.totalSeconds
            }
        }

        print(response.data.count)
        print(megaArray)
    }

    //    private func setupPieChart(dataPoints: [String], values: [Double]) {
    //        // 1. Set ChartDataEntry
    //         var dataEntries: [ChartDataEntry] = []
    //         for i in 0..<dataPoints.count {
    //           let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
    //           dataEntries.append(dataEntry)
    //         }
    //         // 2. Set ChartDataSet
    //         let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
    //         pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
    //         // 3. Set ChartData
    //         let pieChartData = PieChartData(dataSet: pieChartDataSet)
    //         let format = NumberFormatter()
    //         format.numberStyle = .none
    //         let formatter = DefaultValueFormatter(formatter: format)
    //         pieChartData.setValueFormatter(formatter)
    //         // 4. Assign it to the chart’s data
    //         pieChartView.data = pieChartData
    //    }
}
