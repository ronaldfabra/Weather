//
//  GetWeatherDetailUseCaseTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class GetWeatherDetailUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let weatherRepository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: weatherRepository)
        do {
            // When
            let response = try await getWeatherDetailUseCase.execute(location: location)
            // Then
            #expect(response.location.id == weatherRepository.mockWeatherResponse.location.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithInvalidLatitude() async throws {
        // Given
        let location = LocationDomainModel(
            id: 0,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
        let weatherRepository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: weatherRepository)
        do {
            // When
            let _ = try await getWeatherDetailUseCase.execute(location: location)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
            #expect(error.errorIcon == NetworkErrorType.invalidData.errorIcon)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
