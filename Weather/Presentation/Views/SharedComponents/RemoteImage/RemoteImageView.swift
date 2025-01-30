//
//  RemoteImageView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import SwiftUI

struct RemoteImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    var url: URL

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.load(from: url)
        }
    }
}
