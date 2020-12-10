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
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

        createChartsWithLabels()
    }

    private func createChartsWithLabels() {
        scrollView.addSubview(categoryChart)
        categoryChart.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        categoryChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        categoryChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        categoryChart.heightAnchor.constraint(equalToConstant: 250).isActive = true

        scrollView.addSubview(languagesLabel)
        languagesLabel.topAnchor.constraint(equalTo: categoryChart.bottomAnchor, constant: 20).isActive = true
        languagesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        scrollView.addSubview(languagesChart)
        languagesChart.topAnchor.constraint(equalTo: languagesLabel.bottomAnchor).isActive = true
        languagesChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        languagesChart.heightAnchor.constraint(equalToConstant: 250).isActive = true

        scrollView.addSubview(editorsLabel)
        editorsLabel.topAnchor.constraint(equalTo: languagesChart.bottomAnchor, constant: 10).isActive = true
        editorsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        scrollView.addSubview(editorsChart)
        editorsChart.topAnchor.constraint(equalTo: editorsLabel.bottomAnchor).isActive = true
        editorsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        editorsChart.heightAnchor.constraint(equalToConstant: 250).isActive = true
        editorsChart.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        addSubview(activityIndicator)
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        label.isHidden = true
        return label
    }()

    public var languagesChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false

        return chart
    }()

    public var editorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "EDITORS"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.isHidden = true
        return label
    }()

    public var editorsChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false

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
