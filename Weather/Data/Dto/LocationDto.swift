//
//  LocationDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct LocationDto: Codable {
    let id: Int?
    let name: String, country: String
    let lat: Double, lon: Double
    let localtime: String?
    
    func toDomain() -> LocationDomainModel {
        LocationDomainMapper().mapValue(response: self)
    }
}
