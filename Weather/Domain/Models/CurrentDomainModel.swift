//
//  CurrentDomainModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

struct CurrentDomainModel: Identifiable {
    var id: String { time ?? .empty }
    let time: String?
    let condition: ConditionDomainModel
    let tempC, windKph: Double?
}
