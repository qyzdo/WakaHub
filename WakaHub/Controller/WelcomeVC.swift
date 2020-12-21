//
//  ViewController.swift
//  WakaHub
//
//  Created by Oskar Figiel on 19/11/2020.
//

import UIKit
import OAuthSwift

final class WelcomeVC: UIViewController {

    var auth: OAuth?

    override func loadView() {
        let view = WelcomeView()
         self.view = view
     }

    private var welcomeView: WelcomeView {
        // swiftlint:disable:next force_cast
        return view as! WelcomeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupNavbar()
        welcomeView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        welcomeView.createAccountButton.addTarget(self, action: #selector(createAccountButtonClicked), for: .touchUpInside)

    }

    private func setupNavbar() {
        self.title = "Welcome"
        let refreshBarButton: UIBarButtonItem = UIBarButtonItem(customView: welcomeView.activityIndicator)
        self.navigationItem.rightBarButtonItem = refreshBarButton
    }

    @objc private func loginButtonClicked() {
        auth = OAuth()
        DispatchQueue.main.async {
            self.welcomeView.activityIndicator.startAnimating()
        }
        auth?.authorize { result in
            switch result {
            case .success(let credentials):
                self.saveCredentialsInKeychain(credentials: credentials)
                self.presentLoggedInView()
                DispatchQueue.main.async {
                    self.welcomeView.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presentErrorAlert()
            }
        }
    }

    private func saveCredentialsInKeychain(credentials: OAuthSwiftCredential) {
        KeychainWrapper.shared["Token"] = credentials.oauthToken
        KeychainWrapper.shared["RefreshToken"] = credentials.oauthRefreshToken
    }

    private func presentLoggedInView() {
        let tabBarController = TabBarVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
    }

    private func presentErrorAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Login Error", message: "There is an error in logging you into this application, please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
        }
    }

    @objc private func createAccountButtonClicked() {
        if let url = URL(string: "https://wakatime.com/signup") {
            UIApplication.shared.open(url)
        }
    }
}
