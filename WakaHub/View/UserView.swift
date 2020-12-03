//
//  UserView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts

final class UserView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        let safeArea = self.layoutMarginsGuide

        addSubview(avatarView)
        avatarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        avatarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true

        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(joinedDateLabel)
        stackView.addArrangedSubview(hireableLabel)

        addSubview(languagesChart)
        languagesChart.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5).isActive = true
        languagesChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        languagesChart.heightAnchor.constraint(equalToConstant: 90).isActive = true

        addSubview(editorsChart)
        editorsChart.topAnchor.constraint(equalTo: languagesChart.bottomAnchor, constant: 5).isActive = true
        editorsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        editorsChart.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public let avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()

    public var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()

    public var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var joinedDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public var hireableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hireable"
        label.isHidden = true
        return label
    }()

    public var languagesChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false

        return chart
    }()

    public var editorsChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false

        return chart
    }()
}
