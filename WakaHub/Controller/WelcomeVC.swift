//
//  ViewController.swift
//  WakaHub
//
//  Created by Oskar Figiel on 19/11/2020.
//

import UIKit

final class WelcomeVC: UIViewController {

    var auth: OAuth?

    override func loadView() {
        let view = WelcomeView()
         self.view = view
     }

    var welcomeView: WelcomeView {
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
    }

    private func setupNavbar() {
        title = "Welcome"
    }

    @objc private func loginButtonClicked() {
        auth = OAuth()
        auth?.authorize { result in
            switch result {
            case .success(let credentials):
                KeychainWrapper.shared["Token"] = credentials.oauthToken
                KeychainWrapper.shared["RefreshToken"] = credentials.oauthRefreshToken
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func checkIfLoggedin() -> Bool {
        let logged = KeychainWrapper.shared["Token"] != nil &&
            KeychainWrapper.shared["RefreshToken"] != nil ? true : false
        return logged
    }
}
