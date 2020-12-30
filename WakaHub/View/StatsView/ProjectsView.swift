//
//  ProjectsView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/12/2020.
//

import Charts

final class ProjectsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(projectsLabel)
        projectsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        projectsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(projectsChart)
        projectsChart.topAnchor.constraint(equalTo: projectsLabel.bottomAnchor).isActive = true
        projectsChart.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        projectsChart.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        projectsChart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        projectsChart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

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
}
