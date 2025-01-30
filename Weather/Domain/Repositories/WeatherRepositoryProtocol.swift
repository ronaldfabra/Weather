//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func getWeatherDetail(location: LocationDomainModel) async throws -> WeatherDomainModel
}
