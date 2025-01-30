//
//  ForecastdayDomainModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct ForecastdayDomainModel: Identifiable {
    var id: String { date }
    let date: String
    let day: DayDomainModel
    let hours: [CurrentDomainModel]
}
