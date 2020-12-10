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
        navigationItem.title = "Stats"
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .summaries(startDate: "2020-12-04", endDate: "2020-12-10"), decodeType: Summary.self) { result in
            switch result {
            case .success(let response):
                //print(response)
//                self.setupEditors(response: response)
                self.setupCategory(response: response)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }
    }

    struct Data {
        var name: String
        var time: Double
        var date: String
    }

    private func setupCategory(response: Summary) {
        var arrayOfData = [Data]()

        for array in response.data {
            let date = array.range.date
            if array.categories.count > 0 {
                for object in array.categories {
//                    print(object)
                    let testObject = Data(name: object.name, time: object.totalSeconds, date: date)
                    arrayOfData.append(testObject)
                }
            } else {
                let testObject = Data(name: "Building", time: 0, date: date)
                let testObject2 = Data(name: "Coding", time: 0, date: date)
                let testObject3 = Data(name: "Debugging", time: 0, date: date)

                arrayOfData.append(testObject)
                arrayOfData.append(testObject2)
                arrayOfData.append(testObject3)
            }
        }

        setupChart(data: arrayOfData, response: response)
        print(arrayOfData)
    }

    private func setupChart(data: [Data], response: Summary) {
        var dataPoints = [String]()
        for points in response.data {
            let date = points.range.date
            dataPoints.append(date)
        }

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

        barChartView.rightAxis.enabled = false

        let dataSets = setupDataSets(data: data, dataPoints: dataPoints)
        let chartData = BarChartData(dataSets: dataSets)

        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

        let groupCount = dataPoints.count
        let startValue = 0.0

        chartData.barWidth = barWidth
        barChartView.xAxis.axisMinimum = startValue
        let groupWidth = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(groupWidth)")
        barChartView.xAxis.axisMaximum = startValue + groupWidth * Double(groupCount)

        chartData.groupBars(fromX: startValue, groupSpace: groupSpace, barSpace: barSpace)
        //barChartView.notifyDataSetChanged()

        barChartView.data = chartData
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }

    private func setupLegend() {
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0
        legend.xOffset = 10.0
        legend.yEntrySpace = 0.0
    }

    private func setupDataSets(data: [Data], dataPoints: [String]) -> [BarChartDataSet] {
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
        let buildingDataSet = BarChartDataSet(entries: buildingDataEntries, label: "Building")
        let debuggingDataSet = BarChartDataSet(entries: debuggingDataEntries, label: "Debugging")

        let dataSets = [codingDataSet, buildingDataSet, debuggingDataSet]
        codingDataSet.colors = [UIColor.red]
        buildingDataSet.colors = [UIColor.blue]
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
