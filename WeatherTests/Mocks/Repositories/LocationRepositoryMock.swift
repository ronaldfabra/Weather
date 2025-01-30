//
//  LocationRepositoryMock.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Foundation

class LocationRepositoryMock: LocationRepositoryProtocol {

    var mockLocationsResponse: [LocationDomainModel] = [
        .init(
            id: 123,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
    ]

    func searchLocations(query: String) async throws -> [LocationDomainModel] {
        if query.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockLocationsResponse
        }
    }
}
