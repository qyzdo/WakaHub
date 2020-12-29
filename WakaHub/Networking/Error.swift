//
//  Error.swift
//  WakaHub
//
//  Created by Oskar Figiel on 23/12/2020.
//

import Foundation

enum NetworkError {
    case jsonBroken
    case noPremium
    case generalError
    case undefined
    case serverError
    case clientError
    case empty
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .jsonBroken:
            return NSLocalizedString("Sorry we couldn't load your data, please try again later.", comment: "Json data is broken")
        case .noPremium:
            return NSLocalizedString("Sorry you don't have acces to this feature, you need to upgrade to wakatime premium.", comment: "User don't have premium")
        case .generalError:
            return NSLocalizedString("Sorry, there was an error, please try again.", comment: "Just error.")
        case .undefined:
            return NSLocalizedString("Undefined error, please try again later.", comment: "Not known error")
        case .serverError:
            return NSLocalizedString("There was an error in wakatime servers, please try again later.", comment: "Server error.")
        case .clientError:
            return NSLocalizedString("There was an error in our application, please try again later.", comment: "Client error.")
        case .empty:
            return NSLocalizedString("Downloaded data was empty, please try again.", comment: "Empty data downloaded.")
        }
    }
}
