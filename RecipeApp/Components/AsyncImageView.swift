//
//  AsyncImageView.swift
//  RecipeApp
//
//  Created by Subba Nelakudhiti on 1/30/25.
//

import SwiftUI

struct AsyncImageView: View {
    let imageUrl: URL?

    var body: some View {
        AsyncImage(url: imageUrl) { state in
            switch state {
            case .empty: ProgressView()
            case .success(let image): image.resizable()
            case .failure: Image(systemName: "photo").resizable()
            @unknown default: EmptyView()
            }
        }
    }
}

#if DEBUG
#Preview {
    let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")
    return AsyncImageView(imageUrl: url)
}
#endif
