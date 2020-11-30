//
//  Service.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
}

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let token = KeychainWrapper.shared["Token"] {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path

        return urlComponents?.url
    }
}
