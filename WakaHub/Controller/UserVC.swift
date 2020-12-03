//
//  UserVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Kingfisher
import Charts

final class UserVC: UIViewController {

    override func loadView() {
        let view = UserView()
        self.view = view
    }

    private var userView: UserView {
        // swiftlint:disable:next force_cast
        return view as! UserView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupUI()
        loadData()
    }

    private func setupNavbar() {
        navigationItem.title = "Your profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonClicked))
    }

    @objc private func settingsButtonClicked() {
        KeychainWrapper.shared["Token"] = nil
        KeychainWrapper.shared["RefreshToken"] = nil

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(WelcomeVC())

    }

    private func setupUI() {
        self.userView.avatarView.kf.indicatorType = .activity
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .user, decodeType: User.self) { result in
            switch result {
            case .success(let resp):
                self.setupView(data: resp.data)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }

        service.load(service: .stats, decodeType: Stats.self) { result in
            switch result {
            case .success(let resp):
                self.setupChart(data: resp.data)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }    }

    private func setupView(data: DataClass) {
        userView.avatarView.kf.setImage(with: URL(string: data.avatarUrl),
                                        options: [
                                            .scaleFactor(UIScreen.main.scale),
                                            .transition(.fade(1)),
                                            .cacheOriginalImage
                                        ])
        userView.nameLabel.text = data.displayName
        userView.userNameLabel.text = "@\(data.username)"

        userView.locationLabel.text = data.location
        userView.emailLabel.text = data.publicEmail
        userView.joinedDateLabel.text = data.createdAt.formatDateWithMonthName()
        userView.hireableLabel.isHidden = !data.isHireable
    }

    private func setupChart(data: StatsDataClass) {
        let chart = userView.chart

        var percentValues = [Double]()
        var languageNames = [String]()

        for language in data.languages {
            percentValues.append(language.percent)
            languageNames.append(language.name)
        }

        var dataEntries = [ChartDataEntry]()

        for iterator in 0..<percentValues.count {
            let entry = BarChartDataEntry(x: Double(iterator), y: Double(percentValues[iterator]))

            dataEntries.append(entry)
        }

        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        barChartDataSet.colors = ChartColorTemplates.material()

        let barChartData = BarChartData(dataSet: barChartDataSet)
        chart.data = barChartData

        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: languageNames)
        chart.xAxis.granularityEnabled = false
        chart.xAxis.granularity = 1
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false

        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false

        //chart.setVisibleXRange(minXRange: 8.0, maxXRange: 8.0)
    }
}
