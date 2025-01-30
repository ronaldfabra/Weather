//
//  SearchLocationsUseCase.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import Foundation

protocol SearchLocationsUseCaseProtocol {
    func execute(query: String) async throws -> [LocationDomainModel]
}

class SearchLocationsUseCase: SearchLocationsUseCaseProtocol {
    private let repository: LocationRepositoryProtocol

    init(repository: LocationRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) async throws -> [LocationDomainModel] {
        try await repository.searchLocations(query: query)
    }
}
