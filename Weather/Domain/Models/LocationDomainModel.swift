//
//  LocationDomainModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

struct LocationDomainModel: Identifiable, Hashable {
    let id: Int?
    let name: String, country: String
    let latitude: Double, longitude: Double
    let localtime: String?
}
