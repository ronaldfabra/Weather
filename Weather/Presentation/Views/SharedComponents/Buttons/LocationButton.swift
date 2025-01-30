//
//  LocationButton.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import SwiftUI

struct LocationButton: View {

    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: WeatherContants.Dimens.spacing10) {
            Image(systemName: WeatherContants.Icons.location)
                .customShadow()

            Text(WeatherContants.Strings.location)
                .font(.system(size: 14.0, weight: .medium))
                .customShadow()
        }
        .padding(WeatherContants.Dimens.spacing10)
        .onTapGesture {
            onButtonPressed?()
        }
    }
}

#Preview {
    LocationButton()
}
