//
//  APIManager.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Foundation

protocol APIManager {
    func fetchData<T: Codable>(from endPoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension APIManager {
    func fetchData<T: Codable>(from endPoint: Endpoint, responseModel: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.host
        urlComponents.path = endPoint.path

        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.header

        if let body = endPoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        let dataModel = try JSONDecoder().decode(responseModel, from: mapResponse(networkResponse: (data, response)))
        return dataModel
    }

    private func mapResponse(networkResponse: (data: Data, urlResponse: URLResponse)) throws -> Data {
        guard let httpResponse = networkResponse.urlResponse as? HTTPURLResponse else {
            throw APIError.noResponse
        }
        switch httpResponse.statusCode {
        case 200..<300:
            return networkResponse.data
        case 401:
            throw APIError.unauthorized
        default:
            throw APIError.networkError(statusCode: httpResponse.statusCode,
                                        httpResponse: httpResponse,
                                        data: networkResponse.data)
        }
    }
}
