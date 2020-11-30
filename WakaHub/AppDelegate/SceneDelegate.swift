//
//  SceneDelegate.swift
//  WakaHub
//
//  Created by Oskar Figiel on 19/11/2020.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        if url.host == "oauth-callback" {
            OAuthSwift.handle(url: url)
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: windowScene)

        //Change "true" one to other view controller when created
        let viewController = isLoggedIn() ? WelcomeVC() : WelcomeVC()

        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }

    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }

        window.rootViewController = viewController

        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionCrossDissolve],
                          animations: nil,
                          completion: nil)
    }

    private func isLoggedIn() -> Bool {
        let logged = KeychainWrapper.shared["Token"] != nil &&
            KeychainWrapper.shared["RefreshToken"] != nil ? true : false
        return logged
    }
}
