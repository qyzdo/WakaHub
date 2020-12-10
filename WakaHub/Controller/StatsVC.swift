//
//  StatsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts

final class StatsVC: UIViewController {

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
            for array in response.data {
                for object in array.categories {
                    let testObject = Data(name: object.name, time: object.totalSeconds, date: date)
                    arrayOfData.append(testObject)
                }
            }
        }

        setupChart(data: arrayOfData)
        print(arrayOfData)
    }

    private func setupChart(data: [Data]) {
        print(data)
        let barChartView = statsView.categoryChart
        let dataPoints = data.map { $0.date }

        let coding = data.filter { $0.name == "Coding"}.map { $0.time}
        let building = data.filter { $0.name == "Building"}.map { $0.time}
        let debugging = data.filter { $0.name == "Debugging"}.map { $0.time}

        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0
        legend.xOffset = 10.0
        legend.yEntrySpace = 0.0

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
        //axisFormatDelegate = self

        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        var dataEntries2: [BarChartDataEntry] = []

        for iterator in 0..<dataPoints.count {

            var y1 = 0.0
            if coding.indices.contains(iterator) {
                y1 = coding[iterator]
            }

            let dataEntry = BarChartDataEntry(x: Double(iterator), y: y1)
            dataEntries.append(dataEntry)

            var y2 = 0.0
            if building.indices.contains(iterator) {
                y2 = building[iterator]
            }
            let dataEntry1 = BarChartDataEntry(x: Double(iterator), y: y2)
            dataEntries1.append(dataEntry1)

            var y3 = 0.0
            if debugging.indices.contains(iterator) {
                y3 = debugging[iterator]
            }
            let dataEntry2 = BarChartDataEntry(x: Double(iterator), y: y3)
            dataEntries2.append(dataEntry2)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Coding")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "Building")
        let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Debugging")

        let dataSets = [chartDataSet, chartDataSet1, chartDataSet2]
        chartDataSet.colors = [UIColor.red]
        chartDataSet1.colors = [UIColor.blue]
        chartDataSet2.colors = [ UIColor.green]

        let chartData = BarChartData(dataSets: dataSets)

        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = 0.3
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"

        let groupCount = dataPoints.count
        let startYear = 0

        chartData.barWidth = barWidth
        barChartView.xAxis.axisMinimum = Double(startYear)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        print("Groupspace: \(gg)")
        barChartView.xAxis.axisMaximum = Double(startYear) + gg * Double(groupCount)

        chartData.groupBars(fromX: Double(startYear), groupSpace: groupSpace, barSpace: barSpace)
        //chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()

        barChartView.data = chartData

        //background color
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)

        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
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
