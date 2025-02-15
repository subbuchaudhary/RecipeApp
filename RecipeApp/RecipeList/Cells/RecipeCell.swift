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
            AsyncImageView(imageUrl: recipe.photoUrlSmall)
            .frame(width: 60, height: 60)
            .cornerRadius(8)
            .accessibilityIdentifier("RecipeCell.Image")


            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 37/255.0, green: 66/255.0, blue: 146/255.0))
                    .accessibilityIdentifier("RecipeCell.RecipeName")
                Text(recipe.cuisine)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 80/255.0, green: 80/255.0, blue: 80/255.0))
                    .accessibilityIdentifier("RecipeCell.CuisineName")
            }
        }
    }
}

#if DEBUG
#Preview {
    RecipeCell(recipe: Recipe.mockRecipe)
}
#endif
