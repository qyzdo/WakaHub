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
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
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

        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(joinedDateLabel)
        stackView.addArrangedSubview(hireableLabel)

        createChartsWithLabels()
    }

    private func createChartsWithLabels() {
        scrollView.addSubview(languagesLabel)
        languagesLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        languagesLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        scrollView.addSubview(languagesChart)
        languagesChart.topAnchor.constraint(equalTo: languagesLabel.bottomAnchor).isActive = true
        languagesChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        languagesChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(editorsLabel)
        editorsLabel.topAnchor.constraint(equalTo: languagesChart.bottomAnchor, constant: 10).isActive = true
        editorsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        scrollView.addSubview(editorsChart)
        editorsChart.topAnchor.constraint(equalTo: editorsLabel.bottomAnchor).isActive = true
        editorsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        editorsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true

        scrollView.addSubview(operatingSystemsLabel)
        operatingSystemsLabel.topAnchor.constraint(equalTo: editorsChart.bottomAnchor, constant: 10).isActive = true
        operatingSystemsLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true

        scrollView.addSubview(operatingSystemsChart)
        operatingSystemsChart.topAnchor.constraint(equalTo: operatingSystemsLabel.bottomAnchor).isActive = true
        operatingSystemsChart.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        operatingSystemsChart.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        operatingSystemsChart.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

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
        label.text = " hireable "
        label.isHidden = true
        label.backgroundColor = UIColor(red: 89/255, green: 183/255, blue: 215/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 3
        return label
    }()

    public var languagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "LANGUAGES"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.isHidden = true
        return label
    }()

    public var languagesChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false
        chart.isHidden = true

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

    public var editorsChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false
        chart.isHidden = true

        return chart
    }()

    public var operatingSystemsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OPERATING SYSTEMS"
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.isHidden = true
        return label
    }()

    public var operatingSystemsChart: HorizontalBarChartView = {
        let chart = HorizontalBarChartView()
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.setScaleEnabled(false)
        chart.legend.enabled = false
        chart.isHidden = true

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
