//
//  LocationRepositoryTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class LocationRepositoryTests {
    @Test func searchLocation() async throws {
        // Given
        let query = "Santa Marta"
        let network = NetworkMock<[LocationDto]>()
        let mockResponse: [LocationDto] = [.init(id: 1234,
                                                 name: "Santa Marta",
                                                 country: "Colombia",
                                                 lat: 12.5,
                                                 lon: -7.23,
                                                 localtime: nil)]
        network.mockResponse = mockResponse
        let repository: LocationRepositoryProtocol = LocationRepository(network: network)
        do {
            // When
            let response = try await repository.searchLocations(query: query)
            // Then
            #expect(response.count == mockResponse.count)
            #expect(response.first?.id == mockResponse.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func searchLocationWithInvalidQuery() async throws {
        // Given
        let query = "2323"
        let network = NetworkMock<[LocationDto]>()
        let repository: LocationRepositoryProtocol = LocationRepository(network: network)
        do {
            // When
            let _ = try await repository.searchLocations(query: query)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
            #expect(error.errorIcon == NetworkErrorType.invalidData.errorIcon)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
