//
//  ForecastDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class ForecastDomainMapper: Mapper<ForecastDto, ForecastDomainModel> {
    override func mapValue(response: ForecastDto) -> ForecastDomainModel {
        return ForecastDomainModel(forecastday: response.forecastday.map { $0.toDomain() })
    }
}
