//
//  ProjectsView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/12/2020.
//

import Charts

final class ChartWithLabelView: UIView {

    var chart: ChartViewBase

    required init(chart: ChartViewBase) {
        self.chart = chart
        super.init(frame: CGRect.zero)

        self.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(chart)
        chart.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        chart.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        chart.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 300).isActive = true
        chart.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
}
