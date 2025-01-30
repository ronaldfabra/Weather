//
//  TemperatureBarViewModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

import SwiftUI

class TemperatureBarViewModel: ObservableObject {

    @Published var weatherData: DayDomainModel

    init(weatherData: DayDomainModel) {
        self.weatherData = weatherData
    }

    var minTemperature: String {
        String(format: "%@: %@",
               WeatherContants.Strings.min.capitalized,
               WeatherUtils.getTempString(temp: weatherData.mintempC))
    }

    var minTemperatureBarWidth: CGFloat {
        CGFloat(max((weatherData.mintempC ?? .zero) / 50, 0)) * 200
    }

    var maxTemperature: String {
        String(format: "%@: %@",
               WeatherContants.Strings.max.capitalized,
               WeatherUtils.getTempString(temp: weatherData.maxtempC))
    }
    var maxTemperatureBarWidth: CGFloat {
        CGFloat(max((weatherData.maxtempC ?? .zero) / 50, 0)) * 200
    }

    func temperatureColor(for temperature: Double) -> Color {
        switch temperature {
        case ..<0:
            return Color.blue
        case 0..<15:
            return Color.blue.opacity(0.6)
        case 15..<25:
            return Color.green
        case 25..<35:
            return Color.orange
        case 35...:
            return Color.red
        default:
            return Color.gray
        }
    }
}
