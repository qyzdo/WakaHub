//
//  UserView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Charts
import Kingfisher

final class UserView: UIView {
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

        scrollView.addSubview(avatarView)
        avatarView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 5).isActive = true
        avatarView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        avatarView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true

        scrollView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        scrollView.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true

        createStackView()

        scrollView.addSubview(codingActivityLabel)
        codingActivityLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15).isActive = true
        codingActivityLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        codingActivityLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(dailyAverageLabel)
        dailyAverageLabel.topAnchor.constraint(equalTo: codingActivityLabel.bottomAnchor, constant: 15).isActive = true
        dailyAverageLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        dailyAverageLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(totalTimeLabel)
        totalTimeLabel.topAnchor.constraint(equalTo: dailyAverageLabel.bottomAnchor, constant: 15).isActive = true
        totalTimeLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        totalTimeLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        createChartsWithLabels()
    }

    private func createStackView() {
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        hireableLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        hireableLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true

        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(joinedDateLabel)
        stackView.addArrangedSubview(hireableLabel)
    }

    private func createChartsWithLabels() {
        scrollView.addSubview(languagesView)
        languagesView.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor).isActive = true
        languagesView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(editorsView)
        editorsView.topAnchor.constraint(equalTo: languagesView.bottomAnchor).isActive = true
        editorsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(operatingSystemsView)
        operatingSystemsView.topAnchor.constraint(equalTo: editorsView.bottomAnchor).isActive = true
        operatingSystemsView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        operatingSystemsView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        operatingSystemsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

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
        stackView.distribution = .equalSpacing
        stackView.spacing = 5

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
        label.text = "hireable"
        label.isHidden = true
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 89/255, green: 183/255, blue: 215/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()

    public var codingActivityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    public var dailyAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    public var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    public var languagesView: ChartWithLabelView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "LANGUAGES"
        languagesView.isHidden = true

        return languagesView
    }()

    public var editorsView: ChartWithLabelView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "EDITORS"
        languagesView.isHidden = true

        return languagesView
    }()

    public var operatingSystemsView: ChartWithLabelView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false

        let languagesView = ChartWithLabelView(chart: chart)
        languagesView.translatesAutoresizingMaskIntoConstraints = false
        languagesView.nameLabel.text = "OPERATING SYSTEMS"
        languagesView.isHidden = true

        return languagesView
    }()

    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()

        return indicator
    }()
}
