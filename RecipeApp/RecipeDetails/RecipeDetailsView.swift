//
//  RecipeDetailsView.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
            AsyncImage(url: recipe.photoUrlSmall) {
                $0.aspectRatio(contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
            }
            .frame(width: 210, height: 210)

            Text(recipe.name)
                .font(.title)
                .foregroundColor(Color.black)
            Text(recipe.cuisine)
                .font(.body)
                .foregroundColor(Color.gray)
        }
    }
}

#if DEBUG
#Preview {
    RecipeDetailsView(recipe: Recipe.mockRecipe)
}
#endif
