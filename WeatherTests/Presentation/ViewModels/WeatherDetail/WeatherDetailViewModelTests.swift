//
//  WeatherDetailViewModelTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 30/01/25.
//

@testable import Weather
import Testing
import XCTest

final class WeatherDetailViewModelTests: XCTestCase {

    @MainActor func testFetchWeatherDetail() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$weather.sink { weather in
            if weather != nil {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 2.0)
        // Then
        #expect(viewModel.weather != nil)
        #expect(viewModel.weather?.location.id == repository.mockWeatherResponse.location.id)

        cancellable.cancel()
    }

    @MainActor func testFetchWeatherDetailWithInvalidLatitude() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$error.sink { error in
            if error != .none {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        #expect(viewModel.error.errorIcon == NetworkErrorType.invalidData.errorIcon)

        cancellable.cancel()
    }

    func testDaysForecastLabel() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        // When
        let daysForecastLabel = viewModel.daysForecastLabel
        #expect(daysForecastLabel == String(
            format: "%d %@",
            WeatherContants.values.forecastDaysCount,
            WeatherContants.Strings.daysForecast
        ))
    }

    @MainActor func testExpectedWeatherForNextHourLabel() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$weather.sink { weather in
            if weather != nil {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 1.0)
        let expectedWeatherForNextHourLabel = viewModel.expectedWeatherForNextHourLabel

        guard let weather = viewModel.weather else { return }
        #expect(
            expectedWeatherForNextHourLabel == String(
                format: "%@ %@ %@. %@ %d km/h.",
                viewModel
                    .getNextHourModel(
                        weather: weather
                    )?.condition.text ?? .empty,
                WeatherContants.Strings.conditionsExpectedAround,
                viewModel.getNextHour(weather: weather),
                WeatherContants.Strings.windGustAreUpTo,
                Int(weather.current.windKph ?? .zero)
            )
        )
        cancellable.cancel()
    }

    @MainActor func testMinTemperature() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$weather.sink { weather in
            if weather != nil {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 1.0)
        let minTemperature = viewModel.minTemperature

        guard let weather = viewModel.weather else { return }
        #expect(
            minTemperature == String(format: "%@: %@",
                                                      WeatherContants.Strings.min.capitalized,
                                                      WeatherUtils.getTempString(temp: weather.forecast.forecastday.first?.day.mintempC))
        )
        cancellable.cancel()
    }

    @MainActor func testMaxTemperature() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$weather.sink { weather in
            if weather != nil {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 1.0)
        let maxTemperature = viewModel.maxTemperature

        guard let weather = viewModel.weather else { return }
        #expect(
            maxTemperature == String(format: "%@: %@",
                                     WeatherContants.Strings.max.capitalized,
                                     WeatherUtils.getTempString(temp: weather.forecast.forecastday.first?.day.maxtempC))
        )
        cancellable.cancel()
    }

    @MainActor func testWeatherLocation() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: 10.0,
            longitude: .zero,
            localtime: ""
        )
        let repository = WeatherRepositoryMock()
        let getWeatherDetailUseCase = GetWeatherDetailUseCase(repository: repository)
        let viewModel = WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$weather.sink { weather in
            if weather != nil {
                expectation.fulfill()
            }
        }
        // When
        viewModel.fetchWeatherDetail()
        wait(for: [expectation], timeout: 1.0)
        let weatherLocation = viewModel.weatherLocation

        guard let weather = viewModel.weather else { return }
        #expect(
            weatherLocation == String(format: "%@, %@", weather.location.name, weather.location.country)
        )
        cancellable.cancel()
    }
}
