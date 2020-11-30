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
    }

    override func viewDidAppear(_ animated: Bool) {
        setupNavbar()
    }

    private func setupNavbar() {
        self.tabBarController?.navigationItem.title = "Stats"
    }

}
