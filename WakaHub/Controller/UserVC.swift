//
//  UserVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit
import Kingfisher

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
        self.userView.avatarView.kf.indicatorType = .activity
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .user, decodeType: User.self) { result in
            switch result {
            case .success(let resp):
                self.userView.avatarView.kf.setImage(with: URL(string: resp.data.avatarUrl),
                                                      options: [
                                                              .scaleFactor(UIScreen.main.scale),
                                                              .transition(.fade(1)),
                                                              .cacheOriginalImage
                                                          ])
            case .failure(let error):
                print(error)
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
