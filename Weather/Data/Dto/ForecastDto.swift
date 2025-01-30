//
//  ForecastDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct ForecastDto: Codable {
    let forecastday: [ForecastdayDto]
    
    func toDomain() -> ForecastDomainModel {
        ForecastDomainMapper().mapValue(response: self)
    }
}
