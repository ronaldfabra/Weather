//
//  DayDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class DayDomainMapper: Mapper<DayDto, DayDomainModel> {
    override func mapValue(response: DayDto) -> DayDomainModel {
        return DayDomainModel(maxtempC: response.maxtempC,
                              mintempC: response.mintempC,
                              avgtempC: response.avgtempC,
                              condition: response.condition.toDomain())
    }
}
