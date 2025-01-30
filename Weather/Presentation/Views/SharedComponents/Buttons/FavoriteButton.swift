//
//  FavoriteButton.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import SwiftUI

struct FavoriteButton: View {

    @State var isFavorite: Bool = false
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: WeatherContants.Dimens.spacing10) {
            ZStack {
                Image(systemName: WeatherContants.Icons.favorite)
                    .opacity(isFavorite ? 1 : .zero)
                    .scaleEffect(isFavorite ? 1.0 : .zero)
                    .foregroundColor(Color.yellow)

                Image(systemName: WeatherContants.Icons.notFavorite)
                    .opacity(isFavorite ? .zero : 1)
                    .scaleEffect(isFavorite ? .zero : 1.0)
            }
            .customShadow()

            Text(WeatherContants.Strings.favorite)
                .font(.system(size: 14.0, weight: .medium))
                .customShadow()
        }
        .padding(WeatherContants.Dimens.spacing10)
        .animation(.bouncy, value: isFavorite)
        .onTapGesture {
            isFavorite = !isFavorite
            onButtonPressed?()
        }
    }
}

#Preview {
    FavoriteButton()
}
