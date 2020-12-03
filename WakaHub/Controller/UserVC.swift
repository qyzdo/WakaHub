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

        // MARK: - Fake data for testing purposes
        loadExampleData()

//        service.load(service: .stats, decodeType: Stats.self) { result in
//            switch result {
//            case .success(let resp):
//                self.setupChart(usageTimeData: resp.data.languages, chart: self.userView.languagesChart)
//                self.setupChart(usageTimeData: resp.data.editors, chart: self.userView.editorsChart)
//                self.setupChart(usageTimeData: resp.data.operatingSystems, chart: self.userView.operatingSystemsChart)
//
//            case .failure(let error):
//                print(error)
//            case .empty:
//                print("No data")
//
//            }
//        }
    }

    private func loadExampleData() {
        let exampleStats = self.createExampleStats()
        self.setupChart(usageTimeData: exampleStats.data.languages, chart: self.userView.languagesChart)
        self.setupChart(usageTimeData: exampleStats.data.editors, chart: self.userView.editorsChart)
        self.setupChart(usageTimeData: exampleStats.data.operatingSystems, chart: self.userView.operatingSystemsChart)
    }

    private func createExampleStats() -> Stats {
        let categories = [UsageTimes]()
        let dependencies = [UsageTimes]()
        let machines = [UsageTimes]()
        let projects = [UsageTimes]()

        let editorXcode = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Xcode", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let editorPycharm = UsageTimes(digital: "", hours: 0, minutes: 0, name: "PyCharm", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let editorVisualStudio = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Visual Studio Code", percent: 50.0, text: "", totalSeconds: 0, machine: nil)

        let editors = [editorXcode, editorPycharm, editorVisualStudio]

        let swiftLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Swift", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let cSharpLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "C#", percent: 50.0, text: "", totalSeconds: 0, machine: nil)
        let pythonLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Python", percent: 25.0, text: "", totalSeconds: 0, machine: nil)

        let languages = [swiftLanguage, cSharpLanguage, pythonLanguage]

        let windows = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Windows", percent: 98.0, text: "", totalSeconds: 0, machine: nil)
        let mac = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Mac", percent: 32.0, text: "", totalSeconds: 0, machine: nil)

        let operatingSystems = [windows, mac]

        let bestDay = BestDay(createdAt: "", date: "", identifier: "", modifiedAt: nil, text: "", totalSeconds: 0)
        let templateDataClass = StatsDataClass(bestDay: bestDay, categories: categories, createdAt: "", dailyAverage: 0, dailyAverageIncludingOtherLanguage: 0, daysIncludingHolidays: 0, daysMinusHolidays: 0, dependencies: dependencies, editors: editors, end: "", holidays: 0, humanReadableDailyAverage: "", readableDailyAvgIncludingOtherLanguage: "", humanReadableTotal: "", humanReadableTotalIncludingOtherLanguage: "", identifier: "", isAlreadyUpdating: false, isCodingActivityVisible: true, isIncludingToday: true, isOtherUsageVisible: true, isStuck: false, isUpToDate: true, languages: languages, machines: machines, modifiedAt: nil, operatingSystems: operatingSystems, percentCalculated: 0, projects: projects, range: "", start: "", status: "", timeout: 0, timezone: "", totalSeconds: 0, totalSecondsIncludingOtherLanguage: 0, userID: "", username: "", writesOnly: false)
        return Stats(data: templateDataClass)
    }

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
        userView.joinedDateLabel.text = "Joined " + data.createdAt.formatDateWithMonthName()
        userView.hireableLabel.isHidden = !data.isHireable
    }

    private func setupChart(usageTimeData: [UsageTimes], chart: HorizontalBarChartView) {
        var percentValues = [Double]()
        var names = [String]()

        for usageTime in usageTimeData {
            percentValues.append(usageTime.percent)
            names.append(usageTime.name)
        }

        let dataEntries = createDataEntries(values: percentValues)

        let barChartDataSet = BarChartDataSet(entries: dataEntries, label: "")
        switch chart {
        case userView.languagesChart:
            barChartDataSet.colors = ChartColorTemplates.material()
        case userView.editorsChart:
            barChartDataSet.colors = ChartColorTemplates.liberty()
        case userView.operatingSystemsChart:
            barChartDataSet.colors = ChartColorTemplates.vordiplom()
        default:
            barChartDataSet.colors = ChartColorTemplates.material()
        }
        barChartDataSet.highlightEnabled = false
        barChartDataSet.valueFormatter = ChartsFormatterPercent()

        let barChartData = BarChartData(dataSet: barChartDataSet)
        chart.data = barChartData

        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: names)
        chart.xAxis.granularityEnabled = false
        chart.xAxis.granularity = 1
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false

        chart.leftAxis.axisMaximum = 100.0
        chart.leftAxis.axisMinimum = 0

        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.drawValueAboveBarEnabled = false

//        chart.setVisibleXRange(minXRange: 8.0, maxXRange: 8.0)
    }

    private func createDataEntries(values: [Double]) -> [ChartDataEntry] {
        var dataEntries = [ChartDataEntry]()

        for iterator in 0..<values.count {
            let entry = BarChartDataEntry(x: Double(iterator), y: Double(values[iterator]))

            dataEntries.append(entry)
        }

        return dataEntries
    }
}
