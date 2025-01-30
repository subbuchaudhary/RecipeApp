//
//  APIError.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/30/25.
//

import Foundation

enum APIError: Error, Equatable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case networkError(statusCode: Int, httpResponse: HTTPURLResponse, data: Data)

    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
