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

        let firstViewController = StatsVC()

        firstViewController.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(systemName: "chart.bar.xaxis"), tag: 0)

        let secondViewController = UserVC()

        secondViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)

        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }
}
