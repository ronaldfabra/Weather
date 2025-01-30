//
//  WeatherDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class WeatherDomainMapper: Mapper<WeatherDto, WeatherDomainModel> {
    override func mapValue(response: WeatherDto) -> WeatherDomainModel {
        return WeatherDomainModel(location: response.location.toDomain(),
                                  current: response.current.toDomain(),
                                  forecast: response.forecast.toDomain())
    }
}
