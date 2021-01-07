//
//  Alert+Extension.swift
//  WakaHub
//
//  Created by Oskar Figiel on 23/12/2020.
//

import UIKit

extension UIViewController {

    func showAlert(msg: String, title: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
