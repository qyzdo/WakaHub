//
//  SettingsView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 16/12/2020.
//

import UIKit

final class SettingsView: UIView {
    var safeArea: UILayoutGuide!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        safeArea = self.layoutMarginsGuide

        addSubview(logoutButton)
        logoutButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.setTitle("Log out", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
}
