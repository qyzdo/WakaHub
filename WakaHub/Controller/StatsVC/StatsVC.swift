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
    var categoryChartView: BarChartView!
    var languagesChartView: PieChartView!
    var editorsChartView: PieChartView!
    var operatingSystemsChartView: PieChartView!

    let dateSelector = DateSelector()

    var selectedDate: SelectedDate = .sevenDaysAgo {
        didSet {
            self.dateSelector.changedDate(selectedDate: selectedDate)
            self.loadData(startDate: self.dateSelector.startDate, endDate: self.dateSelector.endDate)
            self.statsView.timeSelectButton.setTitle(" Stats for: \(selectedDate.rawValue)", for: .normal)
        }
    }

    override func loadView() {
        let view = StatsView()
        self.view = view
    }

    private var statsView: StatsView {
        // swiftlint:disable:next force_cast
        return view as! StatsView
    }

    override func viewDidAppear(_ animated: Bool) {
        self.dateSelector.updateDate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIActions()
        projectsChartView = statsView.projectsChart
        categoryChartView = statsView.categoryChart
        languagesChartView = statsView.languagesChart
        editorsChartView = statsView.editorsChart
        operatingSystemsChartView = statsView.operatingSystemsChart

        setupUI()
        selectedDate = .sevenDaysAgo
    }

    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Stats"
    }

    private func setupUIActions() {
        var actions = [UIMenuElement]()
        for date in SelectedDate.allCases {
            let element = UIAction(title: date.rawValue) { _ in
                self.selectedDate = date
            }
            actions.append(element)
        }

        let menu = UIMenu(title: "", children: actions)
        statsView.timeSelectButton.menu = menu
    }

    private func loadData(startDate: String, endDate: String) {
        statsView.activityIndicator.startAnimating()

        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .summaries(startDate: startDate, endDate: endDate), decodeType: Summary.self) { result in

            DispatchQueue.main.async {
                self.statsView.activityIndicator.stopAnimating()
            }

            switch result {
            case .success(let response):
                self.setupCategoryChart(usageData: response.data)
                self.setupAllPieCharts(usageData: response.data)

            case .failure(let error):
                self.showAlert(msg: error.localizedDescription)
            }
        }
    }

    private func setupCategoryChart(usageData: [SummaryDataClass]) {
        let categoryChart = CategoryChart(categoryChartView: categoryChartView)
        categoryChart.setupCategoryChart(usageData: usageData)
    }

    private func setupAllPieCharts(usageData: [SummaryDataClass]) {
        let pieChartsCreator = PieChart(languagesChartView: languagesChartView, editorsChartView: editorsChartView, operatingSystemsChartView: operatingSystemsChartView)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .languages)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .editors)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .operatingSystems)
    }
}
