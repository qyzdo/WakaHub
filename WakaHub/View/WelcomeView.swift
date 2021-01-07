//
//  WelcomePageView.swift
//  WakaHub
//
//  Created by Oskar Figiel on 23/11/2020.
//

import UIKit

final class WelcomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        let safeArea = self.layoutMarginsGuide

        addSubview(logoView)
        logoView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5).isActive = true
        logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true

        addSubview(loginButton)
        loginButton.topAnchor.constraint(greaterThanOrEqualTo: logoView.bottomAnchor, constant: 15).isActive = true
        loginButton.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor, constant: 0).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        addSubview(createAccountButton)
        createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 25).isActive = true
        createAccountButton.bottomAnchor.constraint(lessThanOrEqualTo: safeArea.bottomAnchor).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createAccountButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "Logo")
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        imageView.image = tintedImage
        imageView.tintColor = UIColor(named: "LogoColor")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    public let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.setTitle("Create account", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()

    public let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
}
