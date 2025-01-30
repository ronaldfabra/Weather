//
//  WeatherRepository.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import Foundation

class WeatherRepository: WeatherRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getWeatherDetail(location: LocationDomainModel) async throws -> WeatherDomainModel {
        let response = try await network.request(
            endPoint: WeatherEndpoint.weatherDetail(
                location.latitude,
                location.longitude,
                WeatherContants.values.forecastDaysCount
            ),
            type: WeatherDto.self
        )
        return response.toDomain()
    }
}
