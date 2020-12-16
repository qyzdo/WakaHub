//
//  SummaryView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 09/12/2020.
//

import UIKit
import Charts
import Kingfisher

final class StatsView: UIView {
    var safeArea: UILayoutGuide!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        safeArea = self.layoutMarginsGuide

        addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

        createChartsWithLabels()

        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func createChartsWithLabels() {
        scrollView.addSubview(projectsLabel)
        projectsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        projectsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        addProjectsChart()

        scrollView.addSubview(categoriesLabel)
        categoriesLabel.topAnchor.constraint(equalTo: projectsChart.bottomAnchor, constant: 20).isActive = true
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
    }

    private func addProjectsChart() {
        scrollView.addSubview(projectsChart)
        projectsChart.topAnchor.constraint(equalTo: projectsLabel.bottomAnchor).isActive = true
        projectsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        projectsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        projectsChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func addCategoryCharts() {
        scrollView.addSubview(categorySummaryChart)
        categorySummaryChart.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor).isActive = true
        categorySummaryChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        categorySummaryChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        categorySummaryChart.heightAnchor.constraint(equalToConstant: 100).isActive = true

        scrollView.addSubview(categoryChart)
        categoryChart.topAnchor.constraint(equalTo: categorySummaryChart.bottomAnchor).isActive = true
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
        editorsChart.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    public var projectsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PROJECTS"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var projectsChart: BarChartView = {
        let chart = BarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false

        return chart
    }()

    public var categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CATEGORIES"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var categorySummaryChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false

        return chart
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

    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()

        return indicator
    }()
}
