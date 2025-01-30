//
//  WeatherRepositoryMock.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Foundation

class WeatherRepositoryMock: WeatherRepositoryProtocol {

    var mockWeatherResponse: WeatherDomainModel = .init(
        location: .init(
            id: 0,
            name: "",
            country: "",
            latitude: 0.0,
            longitude: 0.0,
            localtime: ""
        ),
        current: .init(time: "",
                       condition: .init(text: "", icon: "", code: 0),
                       tempC: 0.0,
                       windKph: 0.0),
        forecast: .init(
            forecastday: [.init(
                date: "",
                day: .init(
                    maxtempC: .zero,
                    mintempC: .zero,
                    avgtempC: .zero,
                    condition: .init(text: "", icon: "", code: 0)
                ),
                hours: [.init(time: "",
                              condition: .init(text: "", icon: "", code: 0),
                              tempC: .zero,
                              windKph: .zero),
                        .init(time: "2025-01-29 00:00",
                                      condition: .init(text: "", icon: "", code: 0),
                                      tempC: .zero,
                                      windKph: .zero)
                ]
            )]
        )
    )

    func getWeatherDetail(location: Weather.LocationDomainModel) async throws -> WeatherDomainModel {
        if location.latitude == .zero {
            throw NetworkErrorType.invalidData
        } else {
            mockWeatherResponse
        }
    }
}
