//
//  StatsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts

final class StatsVC: UIViewController {
    var projectsChartView: BarChartView!
    var summaryCategoryChartView: HorizontalBarChartView!
    var categoryChartView: BarChartView!
    var languagesChartView: PieChartView!
    var editorsChartView: PieChartView!

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
        projectsChartView = statsView.projectsChart
        summaryCategoryChartView = statsView.categorySummaryChart
        categoryChartView = statsView.categoryChart
        languagesChartView = statsView.languagesChart
        editorsChartView = statsView.editorsChart

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

        service.load(service: .summaries(startDate: "2020-12-08", endDate: "2020-12-14"), decodeType: Summary.self) { result in
            switch result {
            case .success(let response):
                self.setupCategoryChart(usageData: response.data)
                self.setupAllPieCharts(usageData: response.data)
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

    private func setupCategoryChart(usageData: [SummaryDataClass]) {
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
        print("Groupspace: \(groupWidth)")
        categoryChartView.xAxis.axisMaximum = startValue + groupWidth * Double(groupCount)

        chartData.groupBars(fromX: startValue, groupSpace: groupSpace, barSpace: barSpace)

        categoryChartView.data = chartData
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


        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setValueFormatter(SecondsToTimeFormatter())
        pieChartData.setValueTextColor(UIColor.label)

        chartView.entryLabelColor = UIColor.label

        chartView.data = pieChartData
        chartView.animate(xAxisDuration: 1)
    }

    enum ChartType {
        case categories
        case languages
        case editors
    }

    private func setupAllPieCharts(usageData: [SummaryDataClass]) {
        setupPieChart(usageData: usageData, chartType: .languages)
        setupPieChart(usageData: usageData, chartType: .editors)
    }

    private func setupPieChart(usageData: [SummaryDataClass], chartType: ChartType) {
        switch chartType {
        case .languages:
            let dictionary = createNameAndUsageDictionary(usageTimes: usageData, chartType: .languages)

            let usageNames = Array(dictionary.keys)
            let usageTimes = Array(dictionary.values)

            setupPieChartView(dataPoints: usageNames, values: usageTimes, chartView: languagesChartView)
        case .editors:
            let dictionary = createNameAndUsageDictionary(usageTimes: usageData, chartType: .editors)

            let usageNames = Array(dictionary.keys)
            let usageTimes = Array(dictionary.values)

            setupPieChartView(dataPoints: usageNames, values: usageTimes, chartView: editorsChartView)
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

    private func createNameAndUsageDictionary(usageTimes: [SummaryDataClass], chartType: ChartType) -> [String: Double] {
        var arrayData = [SummaryUsageTimes]()
        for array in usageTimes {
            switch chartType {
            case .categories:
                arrayData.append(contentsOf: array.categories)
            case .languages:
                arrayData.append(contentsOf: array.languages)
            case .editors:
                arrayData.append(contentsOf: array.editors)
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
