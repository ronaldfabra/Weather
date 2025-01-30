//
//  TemperatureBarView.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import SwiftUI

struct TemperatureBarView: View {
    @StateObject var viewModel: TemperatureBarViewModel


    init(weatherData: DayDomainModel) {
        self._viewModel = StateObject(wrappedValue: .init(weatherData: weatherData))
    }

    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text(viewModel.minTemperature)
                    .font(.system(size: 14.0, weight: .medium))
                    .customShadow()
                Spacer()
                Text(viewModel.maxTemperature)
                    .font(.system(size: 14.0, weight: .medium))
                    .customShadow()
            }
            .padding()

            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray.opacity(0.4))

                HStack {
                    Rectangle()
                        .frame(width: viewModel.minTemperatureBarWidth)
                        .foregroundColor(viewModel.temperatureColor(for: viewModel.weatherData.mintempC ?? .zero))

                    Rectangle()
                        .frame(width: viewModel.maxTemperatureBarWidth)
                        .foregroundColor(viewModel.temperatureColor(for: viewModel.weatherData.maxtempC ?? .zero))
                }
                .cornerRadius(10)
            }
            .frame(height: 20)
            .customShadow()
            .padding(.horizontal)
        }
    }
}

#Preview {
    TemperatureBarView(
        weatherData: .init(maxtempC: 25.0,
                           mintempC: 15.0,
                           avgtempC: 10.0,
                           condition: .init(text: "",
                                            icon: "",
                                            code: 0))
    )
}
