//
//  APIManager.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case networkError(statusCode: Int, httpResponse: HTTPURLResponse, data: Data)
}

final class APIManager {
    static let shared = APIManager()

    private init() {}

    func fetchData<T: Codable>(from url: String) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        let dataModel = try JSONDecoder().decode(T.self, from: mapResponse(networkResponse: (data, response)))
        return dataModel
    }

    private func mapResponse(networkResponse: (data: Data, urlResponse: URLResponse)) throws -> Data {
        guard let httpResponse = networkResponse.urlResponse as? HTTPURLResponse else {
            return networkResponse.data
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.networkError(statusCode: httpResponse.statusCode,
                                           httpResponse: httpResponse,
                                           data: networkResponse.data)
        }
        return networkResponse.data
    }
}
