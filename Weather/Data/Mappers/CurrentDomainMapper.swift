//
//  CurrentDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class CurrentDomainMapper: Mapper<CurrentDto, CurrentDomainModel> {
    override func mapValue(response: CurrentDto) -> CurrentDomainModel {
        return CurrentDomainModel(time: response.time,
                                  condition: response.condition.toDomain(),
                                  tempC: response.tempC,
                                  windKph: response.windKph)
    }
}
