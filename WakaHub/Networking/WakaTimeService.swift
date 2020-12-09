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
    case summaries(startDate: String, endDate: String)
}

extension WakaTimeService: Service {
    var parameters: [URLQueryItem]? {
        switch self {
        case .summaries(let startDate, let endDate):
           return [URLQueryItem(name: "start", value: startDate), URLQueryItem(name: "end", value: endDate)]
        default:
            return nil
        }
    }

    var baseURL: String {
        return "https://wakatime.com"
    }

    var path: String {
        switch self {
        case .user:
            return "/api/v1/users/current"
        case .stats:
            return "/api/v1/users/current/stats/last_7_days"
        case .summaries:
            return "/api/v1/users/current/summaries"
        }
    }

    var method: ServiceMethod {
        return .get
    }
}
