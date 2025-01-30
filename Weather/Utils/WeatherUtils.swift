//
//  WeatherUtils.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

class WeatherUtils {
    /// This function is to get the day name of a given date
    ///
    /// - Parameter locationDate: this is the current location date
    /// - Parameter dateStr: this is the date to convert to weekday
    ///
    /// - Returns: the weekday, if is the same of locationDate returns today else return the weekday
    ///
    static func getDayName(locationDate: String, dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WeatherContants.DateFormats.date
        guard let date = dateFormatter.date(from: dateStr) else {
            return dateStr
        }
        dateFormatter.dateFormat = WeatherContants.DateFormats.dateWithTime
        guard let currentDate = dateFormatter.date(from: locationDate) else {
            return dateStr
        }
        let calendar = Calendar.current
        let currentDateWithouHour = calendar.startOfDay(for: currentDate)
        let dateWithoutHour = calendar.startOfDay(for: date)

        if currentDateWithouHour == dateWithoutHour {
            return WeatherContants.Strings.today.capitalized
        }
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = WeatherContants.DateFormats.day
        dayFormatter.locale = Locale(identifier: "en_US")
        let dayOfWeek = dayFormatter.string(from: date)
        return dayOfWeek
    }

    static func getConditionIconUrl(conditionIcon: String) -> URL? {
        let conditionURL = conditionIcon.hasPrefix("//")
        ? "https:" + conditionIcon.dropFirst(2)
        : "https://" + conditionIcon
        return URL(string: conditionURL)
    }

    /// This function is to get the hour of a given date
    ///
    /// - Parameter locationDate: this is the current location date
    /// - Parameter dateStr: this is the date to convert to weekday
    ///
    /// - Returns: the hour,  if is the same of locationDate returns Now else return the hour
    ///
    static func getHourFromDate(locationDate: String, dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WeatherContants.DateFormats.dateWithTime
        guard let targetDate = dateFormatter.date(from: dateStr),
              let currentDate = dateFormatter.date(from: locationDate) else {
            return ""
        }
        let calendar = Calendar.current
        let targetHour = calendar.component(.hour, from: targetDate)
        let currentHour = calendar.component(.hour, from: currentDate)
        if targetHour == currentHour {
            return WeatherContants.Strings.now.capitalized
        }
        dateFormatter.dateFormat = WeatherContants.DateFormats.time
        return dateFormatter.string(from: targetDate)
    }

    static func getTempString(temp: Double?) -> String {
        String(format: "%d°C", Int((temp ?? 0.0).rounded(.toNearestOrEven)))
    }

    static func getApiKey() -> String {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        return apiKey ?? .empty
    }
}
