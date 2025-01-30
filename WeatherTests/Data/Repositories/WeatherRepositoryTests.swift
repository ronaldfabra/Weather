//
//  WeatherRepositoryTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class WeatherRepositoryTests {
    @Test func getWeatherDetail() async throws {
        // Given
        let location = LocationDomainModel(
            id: 1234,
            name: "Santa Marta",
            country: "Colombia",
            latitude: 12.5,
            longitude: -7.23,
            localtime: nil
        )
        let network = NetworkMock<WeatherDto>()
        let mockResponse = WeatherDto(
            location: .init(
                id: 1234,
                name: "Santa Marta",
                country: "Colombia",
                lat: 12.5,
                lon: -7.23,
                localtime: nil
            ),
            current: .init(
                time: "",
                condition: .init(
                    text: "",
                    icon: "",
                    code: 0
                ),
                tempC: 28.9,
                windKph: nil
            ),
            forecast: .init(
                forecastday: [.init(
                    date: "",
                    day: .init(
                        maxtempC: nil,
                        mintempC: nil,
                        avgtempC: nil,
                        condition: .init(
                            text: "",
                            icon: "",
                            code: 0
                        )),
                    hours: [.init(
                        time: nil,
                        condition: .init(
                            text: "",
                            icon: "",
                            code: 0
                        ),
                        tempC: nil,
                        windKph: nil)
                    ]
                )]
            )
        )
        network.mockResponse = mockResponse
        let repository: WeatherRepositoryProtocol = WeatherRepository(network: network)
        do {
            // When
            let response = try await repository.getWeatherDetail(location: location)
            // Then
            #expect(response.location.id == mockResponse.location.id)
            #expect(response.current.tempC == mockResponse.current.tempC)
            #expect(response.forecast.forecastday.count == mockResponse.forecast.forecastday.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getWeatherDetailWithInvalidLatitude() async throws {
        // Given
        let location = LocationDomainModel(
            id: 1234,
            name: "Santa Marta",
            country: "Colombia",
            latitude: 0,
            longitude: -7.23,
            localtime: nil
        )
        let network = NetworkMock<WeatherDto>()
        let repository: WeatherRepositoryProtocol = WeatherRepository(network: network)
        do {
            // When
            let response = try await repository.getWeatherDetail(location: location)
            // Then
            #expect(response.forecast.forecastday.isEmpty)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
            #expect(error.errorIcon == NetworkErrorType.invalidData.errorIcon)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
