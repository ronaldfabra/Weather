//
//  WeatherDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct WeatherDto: DTOProtocol {
    let location: LocationDto
    let current: CurrentDto
    let forecast: ForecastDto
    
    func toDomain() -> WeatherDomainModel {
        WeatherDomainMapper().mapValue(response: self)
    }
}
