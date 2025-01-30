//
//  LocationRepositoryProtocol.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

protocol LocationRepositoryProtocol {
    func searchLocations(query: String) async throws -> [LocationDomainModel]
}
