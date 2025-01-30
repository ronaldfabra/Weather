//
//  ForecastdayDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class ForecastdayDomainMapper: Mapper<ForecastdayDto, ForecastdayDomainModel> {
    override func mapValue(response: ForecastdayDto) -> ForecastdayDomainModel {
        return ForecastdayDomainModel(date: response.date,
                                      day: response.day.toDomain(),
                                      hours: response.hours.map { $0.toDomain() })
    }
}
