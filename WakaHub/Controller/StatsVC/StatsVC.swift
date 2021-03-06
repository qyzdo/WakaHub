//
//  StatsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts

final class StatsVC: UIViewController {
    let dateSelector = DateSelector()
    let refreshControl = UIRefreshControl()

    var selectedDate: SelectedDate = .sevenDaysAgo {
        didSet {
            self.dateSelector.changedDate(selectedDate: selectedDate)
            self.loadData(startDate: self.dateSelector.startDate, endDate: self.dateSelector.endDate)
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

        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        statsView.scrollView.refreshControl = refreshControl
    }

    @objc private func refreshData() {
        refreshControl.endRefreshing()
        loadData(startDate: dateSelector.startDate, endDate: dateSelector.endDate)
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
                self.setupTotalLoggedTime(usageData: response.data)
                self.setupDailyAverageChart(usageData: response.data)
                self.setupCategoryChart(usageData: response.data)
                self.setupAllPieCharts(usageData: response.data)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(msg: error.localizedDescription, title: "Ups, there was error loading summary stats!")
                }
            }
        }
    }

    private func setupTotalLoggedTime(usageData: [SummaryDataClass]) {
        let totalTime = usageData.map { $0.grandTotal.totalSeconds }.reduce(0, +).secondsToTime()
        self.statsView.timeSelectButton.setTitle("\(totalTime) in \(self.selectedDate.rawValue)", for: .normal)
    }

    private func setupDailyAverageChart(usageData: [SummaryDataClass]) {
        let dailyAverageChart = DailyAverageChart(dailyAverageView: statsView.dailyAverageView)
        dailyAverageChart.setupChart(usageData: usageData)
    }

    private func setupCategoryChart(usageData: [SummaryDataClass]) {
        guard let categoryChartView = statsView.categoriesView.chart as? BarChartView else {
            return
        }
        let categoryChartCreator = CategoryChartCreator(categoryChartView: categoryChartView)
        categoryChartCreator.setupCategoryChart(usageData: usageData)
    }

    private func setupAllPieCharts(usageData: [SummaryDataClass]) {
        guard let languagesChartView = statsView.languagesView.chart as? PieChartView else {
            return
        }

        guard let editorsChartView = statsView.editorsView.chart as? PieChartView else {
            return
        }

        guard let operatingSystemsChartView = statsView.operatingSystemsView.chart as? PieChartView else {
            return
        }
        let pieChartsCreator = PieChartCreator(languagesChartView: languagesChartView, editorsChartView: editorsChartView, operatingSystemsChartView: operatingSystemsChartView)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .languages)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .editors)
        pieChartsCreator.setupPieChart(usageData: usageData, chartType: .operatingSystems)
    }
}
