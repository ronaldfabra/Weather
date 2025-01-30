//
//  GetWeatherDetailUseCase.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import Foundation

protocol GetWeatherDetailUseCaseProtocol {
    func execute(location: LocationDomainModel) async throws -> WeatherDomainModel
}

class GetWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol {
    private let repository: WeatherRepositoryProtocol

    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(location: LocationDomainModel) async throws -> WeatherDomainModel {
        try await repository.getWeatherDetail(location: location)
    }
}
