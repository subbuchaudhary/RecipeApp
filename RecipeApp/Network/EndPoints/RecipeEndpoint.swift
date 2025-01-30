//
//  RecipeEndpoint.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/30/25.
//

import Foundation

enum RecipeEndpoint {
    case recipes
}

extension RecipeEndpoint: Endpoint {
    var path: String {
        switch self {
        case .recipes:
            return "/recipes.json"
        }
    }

    var method: HTTPRequestMethod {
        switch self {
        case .recipes:
            return .get
        }
    }

    var header: [String : String]? {
        switch self {
        case .recipes:
            return nil
        }
    }

    var body: [String : String]? {
        switch self {
        case .recipes:
            return nil
        }
    }
}
