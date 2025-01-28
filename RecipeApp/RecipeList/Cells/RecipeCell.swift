//
//  RecipeCell.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import SwiftUI

struct RecipeCell: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(url: recipe.photoUrlSmall, scale: 1.0) {
                $0.aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 37/255.0, green: 66/255.0, blue: 146/255.0))
                Text(recipe.cuisine)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 80/255.0, green: 80/255.0, blue: 80/255.0))
            }
        }
    }
}

#if DEBUG
#Preview {
    RecipeCell(recipe: Recipe.mockRecipe)
}
#endif
