//
//  SearchLocationsUseCaseTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class SearchLocationsUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let query = "Santa Marta"
        let locationRepository = LocationRepositoryMock()
        let getWeatherDetailUseCase = SearchLocationsUseCase(repository: locationRepository)
        do {
            // When
            let response = try await getWeatherDetailUseCase.execute(query: query)
            // Then
            #expect(response.count == locationRepository.mockLocationsResponse.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithInvalidQuery() async throws {
        // Given
        let query = ""
        let locationRepository = LocationRepositoryMock()
        let getWeatherDetailUseCase = SearchLocationsUseCase(repository: locationRepository)
        do {
            // When
            let _ = try await getWeatherDetailUseCase.execute(query: query)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
            #expect(error.errorIcon == NetworkErrorType.invalidData.errorIcon)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
