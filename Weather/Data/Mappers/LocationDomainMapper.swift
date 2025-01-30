//
//  LocationDomainMapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

class LocationDomainMapper: Mapper<LocationDto, LocationDomainModel> {
    override func mapValue(response: LocationDto) -> LocationDomainModel {
        return LocationDomainModel(
            id: response.id,
            name: response.name,
            country: response.country,
            latitude: response.lat,
            longitude: response.lon,
            localtime: response.localtime
        )
    }
}
