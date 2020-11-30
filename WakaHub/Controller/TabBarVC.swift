//
//  TabBarVC.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import UIKit

final class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupViewControllers()
    }

    private func setupAppearance() {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.clipsToBounds = true
    }

    private func setupViewControllers() {
        let firstViewController = StatsVC()
        firstViewController.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(systemName: "chart.bar.xaxis"), tag: 0)

        let secondViewController = UserVC()
        secondViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
    }
}
