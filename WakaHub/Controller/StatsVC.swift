//
//  StatsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit

final class StatsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavbar()
        loadData()
    }

    private func setupNavbar() {
        navigationItem.title = "Stats"
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .summaries(startDate: "2020-12-08", endDate: "2020-12-09"), decodeType: Summary.self) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }
    }
}
