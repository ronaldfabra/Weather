//
//  ConditionDomainModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

struct ConditionDomainModel {
    let text, icon: String
    let code: Int
    
    var weatherCondition : WeatherCondition {
        return .fromString(text)
    }
}
