//
//  ServiceProvider.swift
//  WakaHub
//
//  Created by Oskar Figiel on 30/11/2020.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
}

class ServiceProvider<T: Service> {
    var urlSession = URLSession.shared

    func load(service: T, completion: @escaping (NetworkResult<Data>) -> Void) {
        call(service.urlRequest, completion: completion)
    }

    func load<U>(service: T, decodeType: U.Type, completion: @escaping (NetworkResult<U>) -> Void) where U: Decodable {
        call(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let resp = try decoder.decode(decodeType, from: data)
                    completion(.success(resp))
                } catch {
                    completion(.failure(NetworkError.jsonBroken))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension ServiceProvider {
    private func call(_ request: URLRequest, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping (NetworkResult<Data>) -> Void) {
        urlSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(NetworkError.generalError))
            }

            if let httpResponse = response as? HTTPURLResponse {
                deliverQueue.async {
                    switch httpResponse.statusCode {
                    case 100..<200:
                        completion(.failure(NetworkError.generalError))

                    case 200..<300:
                        if let data = data {
                            completion(.success(data))
                        }

                    case 300..<400:
                        completion(.failure(NetworkError.generalError))

                    case 402:
                        completion(.failure(NetworkError.noPremium))

                    case 400..<500:
                        completion(.failure(NetworkError.clientError))

                    case 500..<600:
                        completion(.failure(NetworkError.serverError))

                    default:
                        completion(.failure(NetworkError.undefined))
                    }
                }
            } else {
                deliverQueue.async {
                    completion(.failure(NetworkError.empty))
                }
            }
        }.resume()
    }
}
