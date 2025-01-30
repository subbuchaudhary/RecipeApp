//
//  Endpoint.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/30/25.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var scheme: String { "https" }

    var host: String { "d3jbb8n5wk0qxi.cloudfront.net" }
}
