//
//  WeatherUtilsTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 30/01/25.
//

@testable import Weather
import Testing
import XCTest

final class WeatherUtilsTests {
    @Test func getDayNameForToday() {
        // Given
        let locationDate = "2025-01-30 11:11"
        let dateStr = "2025-01-30"
        // When
        let dayName = WeatherUtils.getDayName(locationDate: locationDate, dateStr: dateStr)
        // Then
        #expect(dayName == WeatherContants.Strings.today.capitalized)
    }

    @Test func getDayNameForTomorrow() {
        // Given
        let locationDate = "2025-01-30 11:11"
        let dateStr = "2025-01-31"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WeatherContants.DateFormats.date
        guard let date = dateFormatter.date(from: dateStr) else { return }
        dateFormatter.dateFormat = WeatherContants.DateFormats.day
        dateFormatter.locale = Locale(identifier: "en_US")
        let dayOfWeek = dateFormatter.string(from: date)
        
        // When
        let dayName = WeatherUtils.getDayName(locationDate: locationDate, dateStr: dateStr)
        // Then
        #expect(dayName == dayOfWeek)
    }

    @Test func getConditionIconUrl() {
        // Given
        let conditionIcon = "//cdn.weatherapi.com/weather/64x64/day/113.png"
        // When
        let url = WeatherUtils.getConditionIconUrl(conditionIcon: conditionIcon)
        // Then
        #expect(url?.absoluteString == "https://cdn.weatherapi.com/weather/64x64/day/113.png")
    }

    @Test func getConditionIconUrlForNew() {
        // Given
        let conditionIcon = "cdn.weatherapi.com/weather/64x64/day/113.png"
        // When
        let url = WeatherUtils.getConditionIconUrl(conditionIcon: conditionIcon)
        // Then
        #expect(
            url?.absoluteString == "https://cdn.weatherapi.com/weather/64x64/day/113.png"
        )
    }

    @Test func getHourFromDate() {
        // Given
        let locationDate = "2025-01-30 11:11"
        let dateStr = "2025-01-30 11:11"
        // When
        let hour = WeatherUtils.getHourFromDate(locationDate: locationDate, dateStr: dateStr)
        // Then
        #expect(hour == WeatherContants.Strings.now.capitalized)
    }

    @Test func getHourFromDateForNextHour() {
        // Given
        let locationDate = "2025-01-30 11:11"
        let dateStr = "2025-01-30 12:00"
        // When
        let hour = WeatherUtils.getHourFromDate(locationDate: locationDate, dateStr: dateStr)
        // Then
        #expect(hour == "12 PM")
    }

    @Test func getTempString() {
        // Given
        let temp = 25.4
        // When
        let tempStr = WeatherUtils.getTempString(temp: temp)
        // Then
        #expect(tempStr == "25°C")
    }

    @Test func getTempUpString() {
        // Given
        let temp = 25.5
        // When
        let tempStr = WeatherUtils.getTempString(temp: temp)
        // Then
        #expect(tempStr == "26°C")
    }
}
