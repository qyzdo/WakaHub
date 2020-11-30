//
//  WakaTimeService.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import Foundation

enum WakaTimeService {
    case user
}

extension WakaTimeService: Service {

    var baseURL: String {
        return "https://wakatime.com"
    }

    var path: String {
        switch self {
        case .user:
            return "/api/v1/users/current"
        }
    }

    var method: ServiceMethod {
        return .get
    }
}
