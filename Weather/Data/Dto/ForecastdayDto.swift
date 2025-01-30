//
//  ForecastdayDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct ForecastdayDto: Codable {
    let date: String
    let day: DayDto
    let hours: [CurrentDto]
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case hours = "hour"
    }
    
    func toDomain() -> ForecastdayDomainModel {
        ForecastdayDomainMapper().mapValue(response: self)
    }
}
