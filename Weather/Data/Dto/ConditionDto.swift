//
//  ConditionDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct ConditionDto: Codable {
    let text, icon: String
    let code: Int
    
    func toDomain() -> ConditionDomainModel {
        ConditionDomainMapper().mapValue(response: self)
    }
}
