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
        setupNavbar()
        setupUI()
        loadData()

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

    private func setupUI() {
        self.userView.avatarView.kf.indicatorType = .activity
    }

    private func loadData() {
        let service = ServiceProvider<WakaTimeService>()

        service.load(service: .user, decodeType: User.self) { result in
            switch result {
            case .success(let resp):
                self.setupView(data: resp.data)
            case .failure(let error):
                print(error)
            case .empty:
                print("No data")

            }
        }
    }

    private func setupView(data: DataClass) {
        userView.avatarView.kf.setImage(with: URL(string: data.avatarUrl),
                                              options: [
                                                      .scaleFactor(UIScreen.main.scale),
                                                      .transition(.fade(1)),
                                                      .cacheOriginalImage
                                                  ])
        userView.nameLabel.text = data.displayName
        userView.userNameLabel.text = "@\(data.username)"

        userView.locationLabel.text = data.location
        userView.emailLabel.text = data.publicEmail
        userView.joinedDateLabel.text = data.createdAt.formatDateWithMonthName()
        userView.hireableLabel.isHidden = !data.isHireable
    }
}
