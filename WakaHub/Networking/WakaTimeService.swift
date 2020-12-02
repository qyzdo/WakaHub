//
//  WakaTimeService.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import Foundation

enum WakaTimeService {
    case user
    case stats
}

extension WakaTimeService: Service {

    var baseURL: String {
        return "https://wakatime.com"
    }

    var path: String {
        switch self {
        case .user:
            return "/api/v1/users/current"
        case .stats:
            return "/api/v1/users/current/stats/last_7_days"
        }
    }

    var method: ServiceMethod {
        return .get
    }
}
