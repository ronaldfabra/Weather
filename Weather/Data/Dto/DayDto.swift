//
//  DayDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct DayDto: Codable {
    let maxtempC, mintempC, avgtempC : Double?
    let condition: ConditionDto
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case condition
    }
    
    func toDomain() -> DayDomainModel {
        DayDomainMapper().mapValue(response: self)
    }
}
