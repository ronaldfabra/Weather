//
//  LocationRepository.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

class LocationRepository: LocationRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func searchLocations(query: String) async throws -> [LocationDomainModel] {
        let response = try await network.request(endPoint: LocationEndpoint.search(query),
                                                 type: [LocationDto].self)
        return response.map { $0.toDomain() }
    }
}
