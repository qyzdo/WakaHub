//
//  SummaryView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 09/12/2020.
//

import UIKit
import Charts

final class StatsView: UIView {
    var safeArea: UILayoutGuide!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        safeArea = self.layoutMarginsGuide

        addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

        scrollView.addSubview(timeSelectButton)
        timeSelectButton.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        timeSelectButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true

        createChartsWithLabels()

        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func createChartsWithLabels() {
        scrollView.addSubview(projectsView)
        projectsView.topAnchor.constraint(equalTo: timeSelectButton.bottomAnchor, constant: 15).isActive = true
        projectsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        projectsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(dailyAverageView)
        dailyAverageView.topAnchor.constraint(equalTo: projectsView.bottomAnchor, constant: 15).isActive = true
        dailyAverageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        dailyAverageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(categoriesLabel)
        categoriesLabel.topAnchor.constraint(equalTo: dailyAverageView.bottomAnchor, constant: 20).isActive = true
        categoriesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addCategoryCharts()

        scrollView.addSubview(languagesLabel)
        languagesLabel.topAnchor.constraint(equalTo: categoryChart.bottomAnchor, constant: 20).isActive = true
        languagesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addLanguagesChart()

        scrollView.addSubview(editorsLabel)
        editorsLabel.topAnchor.constraint(equalTo: languagesChart.bottomAnchor, constant: 20).isActive = true
        editorsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addEditorsChart()

        scrollView.addSubview(operatingSystemsLabel)
        operatingSystemsLabel.topAnchor.constraint(equalTo: editorsChart.bottomAnchor, constant: 20).isActive = true
        operatingSystemsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        addOperatingSystemsChart()
    }

    private func addCategoryCharts() {
        scrollView.addSubview(categoryChart)
        categoryChart.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor).isActive = true
        categoryChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        categoryChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        categoryChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func addLanguagesChart() {
        scrollView.addSubview(languagesChart)
        languagesChart.topAnchor.constraint(equalTo: languagesLabel.bottomAnchor).isActive = true
        languagesChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        languagesChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func addEditorsChart() {
        scrollView.addSubview(editorsChart)
        editorsChart.topAnchor.constraint(equalTo: editorsLabel.bottomAnchor).isActive = true
        editorsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        editorsChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func addOperatingSystemsChart() {
        scrollView.addSubview(operatingSystemsChart)
        operatingSystemsChart.topAnchor.constraint(equalTo: operatingSystemsLabel.bottomAnchor).isActive = true
        operatingSystemsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        operatingSystemsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        operatingSystemsChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        operatingSystemsChart.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    public let timeSelectButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.layer.cornerRadius = 10
        button.role = .normal
        button.showsMenuAsPrimaryAction = true
        return button
    }()

    public var dailyAverageView: DailyAverageView = {
        let dailyAverageView = DailyAverageView()
        dailyAverageView.translatesAutoresizingMaskIntoConstraints = false

        return dailyAverageView
    }()

    public var projectsView: ProjectsView = {
        let projectsView = ProjectsView()
        projectsView.translatesAutoresizingMaskIntoConstraints = false

        return projectsView
    }()

    public var categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CATEGORIES"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var categoryChart: BarChartView = {
        let chart = BarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false

        return chart
    }()

    public var languagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LANGUAGES"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var languagesChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.drawHoleEnabled = false

        return chart
    }()

    public var editorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EDITORS"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var editorsChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.holeColor = .systemBackground

        return chart
    }()

    public var operatingSystemsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OPERATING SYSTEMS"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var operatingSystemsChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.holeColor = .systemBackground

        return chart
    }()

    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        return indicator
    }()
}
