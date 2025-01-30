//
//  CurrentDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct CurrentDto: Codable {
    let time: String?
    let condition: ConditionDto
    let tempC, windKph: Double?
    
    enum CodingKeys: String, CodingKey {
        case time, condition
        case tempC = "temp_c"
        case windKph = "wind_kph"
    }
    
    func toDomain() -> CurrentDomainModel {
        CurrentDomainMapper().mapValue(response: self)
    }
}
