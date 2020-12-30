//
//  DailyAverageView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 29/12/2020.
//

import Charts

class DailyAverageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(dailyAverageLabel)
        dailyAverageLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dailyAverageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(lastDayTimeLabel)
        lastDayTimeLabel.topAnchor.constraint(equalTo: dailyAverageLabel.bottomAnchor, constant: 10).isActive = true
        lastDayTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(dailyAverageChart)
        dailyAverageChart.topAnchor.constraint(equalTo: lastDayTimeLabel.bottomAnchor).isActive = true
        dailyAverageChart.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dailyAverageChart.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dailyAverageChart.heightAnchor.constraint(equalToConstant: 160).isActive = true

        self.addSubview(percentLabel)
        percentLabel.topAnchor.constraint(equalTo: dailyAverageChart.bottomAnchor, constant: 10).isActive = true
        percentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(dailyAverageTimeLabel)
        dailyAverageTimeLabel.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 10).isActive = true
        dailyAverageTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dailyAverageTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    public var dailyAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AVERAGE"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var lastDayTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var dailyAverageChart: PieChartView = {
        let chart = PieChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.maxAngle = 180
        chart.rotationAngle = 180

        chart.holeColor = .systemBackground
        chart.holeRadiusPercent = 0.58
        chart.rotationEnabled = false
        chart.highlightPerTapEnabled = false
        return chart
    }()

    public var percentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    public var dailyAverageTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: label.font.pointSize - 1)

        return label
    }()
}
