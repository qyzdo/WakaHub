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
        loadData()
    }

    private func setupNavbar() {
        self.navigationItem.title = "Your profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(self.settingsButtonClicked))
    }

    @objc private func settingsButtonClicked() {
        let settingsVC = SettingsVC()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .user, decodeType: User.self) { result in
            switch result {
            case .success(let response):
                self.setupView(data: response.data)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }

        // MARK: - Fake data for testing purposes
        //        loadExampleData()

        service.load(service: .stats, decodeType: Stats.self) { result in
            switch result {
            case .success(let response):
                self.setupStatsView(data: response.data)
                self.showCharts()
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }
    }

    private func setupView(data: UserDataClass) {
        DispatchQueue.main.async {
            self.userView.avatarView.kf.indicatorType = .activity
            self.userView.avatarView.kf.setImage(with: URL(string: data.avatarUrl),
                                            options: [
                                                .scaleFactor(UIScreen.main.scale),
                                                .transition(.fade(1)),
                                                .cacheOriginalImage
                                            ])

            self.userView.nameLabel.text = data.displayName
            self.userView.userNameLabel.text = "@\(data.username)"
            self.userView.locationLabel.attributedText = self.setupLabelWithImage(imageName: "location.fill", text: data.location)
            if let publicEmail = data.publicEmail {
                self.userView.emailLabel.attributedText = self.setupLabelWithImage(imageName: "person.crop.circle", text: publicEmail)
            }
            self.userView.joinedDateLabel.attributedText = self.setupLabelWithImage(imageName: "clock", text: "Joined " + data.createdAt.formatDateWithMonthName())
            self.userView.hireableLabel.isHidden = !data.isHireable
        }
    }

    private func setupLabelWithImage(imageName: String, text: String) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: imageName)

        let imageOffsetY: CGFloat = -5.0
        if let image = imageAttachment.image {
            imageAttachment.bounds = CGRect(x: -1, y: imageOffsetY, width: image.size.width, height: image.size.height)
        }

        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let textAfterIcon = NSAttributedString(string: text)
        completeText.append(textAfterIcon)

        return completeText
    }

    private func showCharts() {
        DispatchQueue.main.async {
            self.userView.activityIndicator.stopAnimating()

            self.userView.languagesLabel.isHidden = false
            self.userView.languagesChart.isHidden = false

            self.userView.editorsLabel.isHidden = false
            self.userView.editorsChart.isHidden = false

            self.userView.operatingSystemsLabel.isHidden = false
            self.userView.operatingSystemsChart.isHidden = false
        }
    }

    private func setupStatsView(data: StatsDataClass) {
        self.setupChart(usageTimeData: data.languages, chart: self.userView.languagesChart)
        self.setupChart(usageTimeData: data.editors, chart: self.userView.editorsChart)
        self.setupChart(usageTimeData: data.operatingSystems, chart: self.userView.operatingSystemsChart)

        DispatchQueue.main.async {
            self.userView.codingActivityLabel.attributedText = self.createStatsAttributedString(activityName: "Coding Activity ", timeString: data.humanReadableTotalIncludingOtherLanguage)
            self.userView.dailyAverageLabel.attributedText = self.createStatsAttributedString(activityName: "Daily Average ", timeString: data.humanReadableDailyAverage)
        }
    }

    private func createStatsAttributedString(activityName: String, timeString: String) -> NSMutableAttributedString {
        let activityNameFont = UIFont.systemFont(ofSize: 15)
        let activityNameAttributes = [NSAttributedString.Key.font: activityNameFont]
        let activityNameAttributed = NSAttributedString(string: activityName, attributes: activityNameAttributes)

        let timeFont = UIFont.boldSystemFont(ofSize: 16)
        let timeAttributes = [NSAttributedString.Key.font: timeFont]
        let timeAttributed = NSAttributedString(string: timeString, attributes: timeAttributes)

        let combinedStrings = NSMutableAttributedString()
        combinedStrings.append(activityNameAttributed)
        combinedStrings.append(timeAttributed)

        return combinedStrings
    }

    private func setupChart(usageTimeData: [UsageTimes], chart: HorizontalBarChartView) {
        var percentValues = [Double]()
        var names = [String]()

        for usageTime in usageTimeData {
            percentValues.append(usageTime.percent)
            names.append(usageTime.name)
        }

        let combinedSort = zip(percentValues, names).sorted {$0.0 < $1.0}
        let sortedPercentValues = combinedSort.map {$0.0}
        let sortedNames = combinedSort.map {$0.1}

        let dataEntries = createDataEntries(values: sortedPercentValues)

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
        barChartDataSet.valueFont = UIFont.systemFont(ofSize: 13)
        barChartDataSet.valueTextColor = .black

        let barChartData = BarChartData(dataSet: barChartDataSet)
        chart.data = barChartData

        chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: sortedNames)
        chart.xAxis.granularityEnabled = false
        chart.xAxis.granularity = 1
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false

        chart.leftAxis.axisMaximum = percentValues.max() ?? 100.0
        chart.leftAxis.axisMinimum = 0

        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.drawValueAboveBarEnabled = false

        chart.animate(yAxisDuration: 1)

        chart.heightAnchor.constraint(equalToConstant: CGFloat(45*percentValues.count)).isActive = true
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

extension UserVC {
    private func loadExampleData() {
        let exampleStats = createExampleStats()
        setupStatsView(data: exampleStats.data)
        showCharts()
    }

    private func createExampleStats() -> Stats {
        let categories = [UsageTimes]()
        let dependencies = [UsageTimes]()
        let machines = [UsageTimes]()
        let projects = [UsageTimes]()

        let editorXcode = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Xcode", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let editorPycharm = UsageTimes(digital: "", hours: 0, minutes: 0, name: "PyCharm", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let editorVisualStudio = UsageTimes(digital: "", hours: 0, minutes: 0, name: "VS Code", percent: 50.0, text: "", totalSeconds: 0, machine: nil)

        let editors = [editorXcode, editorPycharm, editorVisualStudio]

        let swiftLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Swift", percent: 25.0, text: "", totalSeconds: 0, machine: nil)
        let cSharpLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "C#", percent: 50.0, text: "", totalSeconds: 0, machine: nil)
        let pythonLanguage = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Python", percent: 25.0, text: "", totalSeconds: 0, machine: nil)

        let languages = [swiftLanguage, cSharpLanguage, pythonLanguage]

        let windows = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Windows", percent: 98.0, text: "", totalSeconds: 0, machine: nil)
        let mac = UsageTimes(digital: "", hours: 0, minutes: 0, name: "Mac", percent: 32.0, text: "", totalSeconds: 0, machine: nil)

        let operatingSystems = [windows, mac]

        let bestDay = BestDay(createdAt: "", date: "", identifier: "", modifiedAt: nil, text: "", totalSeconds: 0)
        let templateDataClass = StatsDataClass(bestDay: bestDay,
                                               categories: categories,
                                               createdAt: "",
                                               dailyAverage: 0,
                                               dailyAverageIncludingOtherLanguage: 0,
                                               daysIncludingHolidays: 0,
                                               daysMinusHolidays: 0,
                                               dependencies: dependencies,
                                               editors: editors,
                                               end: "",
                                               holidays: 0,
                                               humanReadableDailyAverage: "2 hrs 11 mins",
                                               readableDailyAvgIncludingOtherLanguage: "",
                                               humanReadableTotal: "",
                                               humanReadableTotalIncludingOtherLanguage: "8 hrs 47 mins",
                                               identifier: "",
                                               isAlreadyUpdating: false,
                                               isCodingActivityVisible: true,
                                               isIncludingToday: true,
                                               isOtherUsageVisible: true,
                                               isStuck: false,
                                               isUpToDate: true,
                                               languages: languages,
                                               machines: machines,
                                               modifiedAt: nil,
                                               operatingSystems: operatingSystems,
                                               percentCalculated: 0,
                                               projects: projects,
                                               range: "",
                                               start: "",
                                               status: "",
                                               timeout: 0,
                                               timezone: "",
                                               totalSeconds: 0,
                                               totalSecondsIncludingOtherLanguage: 0,
                                               userID: "",
                                               username: "",
                                               writesOnly: false)
        return Stats(data: templateDataClass)
    }
}
