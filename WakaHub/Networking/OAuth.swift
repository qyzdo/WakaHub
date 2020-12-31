//
//  OAuth.swift
//  WakaHub
//
//  Created by Oskar Figiel on 23/11/2020.
//

import OAuthSwift

final class OAuth {
    private var oAuthHandler: OAuth2Swift?

    func authorize(completion: @escaping (Result<OAuthSwiftCredential, OAuthSwiftError>) -> Void) {
        createOAuthHandler()
        oAuthHandler?.authorize(
            withCallbackURL: "wakahub://oauth-callback/wakatime",
            scope: "email, read_logged_time, read_stats, read_orgs, read_private_leaderboards", state: "") { result in
            switch result {
            case .success(let response):
                completion(.success(response.credential))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func createOAuthHandler() {
        oAuthHandler = OAuth2Swift(
            consumerKey: OAuthKeys.consumerKey,
            consumerSecret: OAuthKeys.consumerSecret,
            authorizeUrl: "https://wakatime.com/oauth/authorize",
            accessTokenUrl: "https://wakatime.com/oauth/token",
            responseType: "code"
        )
        oAuthHandler?.allowMissingStateCheck = true
    }
}
