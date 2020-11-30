//
//  UserVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit

final class UserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewDidAppear(_ animated: Bool) {
        setupNavbar()
    }

    private func setupNavbar() {
        navigationItem.title = "Your profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonClicked))
    }

    @objc private func settingsButtonClicked() {
        print("Opened settings")
    }

}
