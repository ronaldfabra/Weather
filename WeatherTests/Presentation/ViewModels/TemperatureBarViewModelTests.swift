//
//  TemperatureBarViewModelTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 30/01/25.
//

@testable import Weather
import Testing
import XCTest
import SwiftUI

final class TemperatureBarViewModelTests {

    @Test func minTemperature() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let minTemperature = viewModel.minTemperature
        // Then
        #expect(minTemperature == "Min: 20°C")
    }

    @Test func minTemperatureBarWidth() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let minTemperatureBarWidth = viewModel.minTemperatureBarWidth
        // Then
        #expect(minTemperatureBarWidth == CGFloat(max((20.0) / 50, 0)) * 200)
    }

    @Test func maxTemperature() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let maxTemperature = viewModel.maxTemperature
        // Then
        #expect(maxTemperature == "Max: 30°C")
    }

    @Test func maxTemperatureBarWidth() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let maxTemperatureBarWidth = viewModel.maxTemperatureBarWidth
        // Then
        #expect(maxTemperatureBarWidth == CGFloat(max((30.0) / 50, 0)) * 200)
    }

    @Test func temperatureColor() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: -1.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let color = viewModel.temperatureColor(for: weatherData.mintempC ?? .zero)
        // Then
        #expect(color == Color.blue)
    }

    @Test func temperatureColorFor5Degree() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 5.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let color = viewModel.temperatureColor(for: weatherData.mintempC ?? .zero)
        // Then
        #expect(color == Color.blue.opacity(0.6))
    }

    @Test func temperatureColorFor20Degree() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let color = viewModel.temperatureColor(for: weatherData.mintempC ?? .zero)
        // Then
        #expect(color == Color.green)
    }

    @Test func temperatureColorFor30Degree() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 30.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let color = viewModel.temperatureColor(for: weatherData.maxtempC ?? .zero)
        // Then
        #expect(color == Color.orange)
    }

    @Test func temperatureColorFor40Degree() {
        // Given
        let weatherData = DayDomainModel(
            maxtempC: 40.0,
            mintempC: 20.0,
            avgtempC: 26.0,
            condition: .init(text: "", icon: "", code: 0)
        )
        let viewModel = TemperatureBarViewModel(weatherData: weatherData)
        // When
        let color = viewModel.temperatureColor(for: weatherData.maxtempC ?? .zero)
        // Then
        #expect(color == Color.red)
    }
}
