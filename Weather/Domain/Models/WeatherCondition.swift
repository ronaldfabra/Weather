//
//  WeatherCondition.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

enum WeatherCondition {
    case sunny
    case cloudy
    case mist
    case rain
    case snow
    case blizzard
    case thundery
    case clear

    static func fromString(_ string: String) -> WeatherCondition {
        let weatherKeywords: [WeatherCondition: [String]] = [
            .sunny: ["sunny"],
            .cloudy: ["cloudy", "overcast"],
            .mist: ["mist", "fog"],
            .rain: ["rain", "drizzle", "sleet"],
            .snow: ["snow", "ice pellets"],
            .blizzard: ["blizzard"],
            .thundery: ["thundery"]
        ]

        for (condition, keywords) in weatherKeywords {
            if keywords.contains(where: { string.lowercased().contains($0) }) {
                return condition
            }
        }
        return .clear
    }

    func getBackgroundImage() -> String {
        switch self {
        case .sunny: WeatherContants.Images.sunny
        case .cloudy: WeatherContants.Images.cloudy
        case .mist: WeatherContants.Images.mist
        case .rain: WeatherContants.Images.rain
        case .snow: WeatherContants.Images.snow
        case .blizzard: WeatherContants.Images.blizzard
        case .thundery: WeatherContants.Images.thundery
        case .clear: WeatherContants.Images.clear
        }
    }
}
