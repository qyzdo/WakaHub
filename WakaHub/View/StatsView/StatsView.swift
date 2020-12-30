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

        scrollView.addSubview(categoriesView)
        categoriesView.topAnchor.constraint(equalTo: dailyAverageView.bottomAnchor, constant: 15).isActive = true
        categoriesView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        categoriesView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(languagesView)
        languagesView.topAnchor.constraint(equalTo: categoriesView.bottomAnchor, constant: 20).isActive = true
        languagesView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(editorsView)
        editorsView.topAnchor.constraint(equalTo: languagesView.bottomAnchor, constant: 20).isActive = true
        editorsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(operatingSystemsView)
        operatingSystemsView.topAnchor.constraint(equalTo: editorsView.bottomAnchor, constant: 20).isActive = true
        operatingSystemsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        operatingSystemsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        operatingSystemsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
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

    public var projectsView: ChartWithLabelView = {
        let chart = BarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let projectsView = ChartWithLabelView(chart: chart)
        projectsView.translatesAutoresizingMaskIntoConstraints = false
        projectsView.nameLabel.text = "PROJECTS"

        return projectsView
    }()

    public var dailyAverageView: DailyAverageView = {
        let dailyAverageView = DailyAverageView()
        dailyAverageView.translatesAutoresizingMaskIntoConstraints = false

        return dailyAverageView
    }()

    public var categoriesView: ChartWithLabelView = {
        let chart = BarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "CATEGORIES"

        return languagesView
    }()

    public var languagesView: ChartWithLabelView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.drawHoleEnabled = false

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "LANGUAGES"

        return languagesView
    }()

    public var editorsView: ChartWithLabelView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.holeColor = .systemBackground

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "EDITORS"

        return languagesView
    }()

    public var operatingSystemsView: ChartWithLabelView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.holeColor = .systemBackground

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "OPERATING SYSTEMS"

        return languagesView
    }()

    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true

        return indicator
    }()
}
