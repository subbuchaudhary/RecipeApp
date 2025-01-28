//
//  CuisineSelectionView.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/27/25.
//

import SwiftUI

struct CuisineSelectionView: View {
    let cuisines: [String]
    @Binding var selectedCuisine: String
    @Binding var isShowingPopup: Bool
    var callBack: (() -> Void)?

    var body: some View {
        NavigationView {
            List(cuisines, id: \.self) { cuisine in
                Button(action: {
                    selectedCuisine = cuisine
                    callBack?()
                    isShowingPopup = false
                }) {
                    HStack {
                        Text(cuisine)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if cuisine == selectedCuisine {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Select Cuisine")
            .navigationBarItems(trailing: Button("Close") {
                isShowingPopup = false
            })
        }
    }
}
