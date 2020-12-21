//
//  SettingsVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 16/12/2020.
//

import UIKit

class SettingsVC: UIViewController {

    override func loadView() {
        let view = SettingsView()
        self.view = view
    }

    private var settingsView: SettingsView {
        // swiftlint:disable:next force_cast
        return view as! SettingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Settings"

        settingsView.logoutButton.addTarget(self, action: #selector(logoutClicked), for: .touchUpInside)
    }

    @objc private func logoutClicked() {
        KeychainWrapper.shared["Token"] = nil
        KeychainWrapper.shared["RefreshToken"] = nil

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(WelcomeVC())
    }

}
