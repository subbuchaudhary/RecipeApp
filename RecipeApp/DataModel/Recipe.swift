//
//  Recipe.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import Foundation

struct RecipeDataModel: Codable, Hashable {
    var recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    var cuisine: String
    var name: String
    var photoUrlStringLarge: String?
    var photoUrlStringSmall: String?
    var sourceUrl: String?
    var uuid: String
    var youtubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case cuisine
        case name
        case photoUrlStringLarge = "photo_url_large"
        case photoUrlStringSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }

    var photoUrlSmall: URL? {
        guard let photoUrlStringSmall else { return nil }
        return URL(string: photoUrlStringSmall)
    }

    var photoUrlLarge: URL? {
        guard let photoUrlStringLarge else { return nil }
        return URL(string: photoUrlStringLarge)
    }
}

#if DEBUG
extension Recipe {
    static let mockRecipe: Recipe = Recipe(cuisine: "Malaysian",
                                           name: "Apam Balik",
                                           photoUrlStringLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                                           photoUrlStringSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                                           sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                                           uuid: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                                           youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg")
}
#endif
