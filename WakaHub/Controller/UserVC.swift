//
//  UserVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit

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
        let service = ServiceProvider<WakaTimeService>()
        service.load(service: .user) { result in
            switch result {
            case .success(let resp):
                print(String(decoding: resp, as: UTF8.self))
            case .failure(let error):
                print(error.localizedDescription)
            case .empty:
                print("No data")

            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        setupNavbar()
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

}
