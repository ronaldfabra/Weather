//
//  ImageLoader.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil

    private var cancellable: AnyCancellable?

    func load(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
