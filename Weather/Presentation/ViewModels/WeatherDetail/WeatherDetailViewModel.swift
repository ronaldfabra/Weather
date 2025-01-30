//
//  WeatherDetailViewModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import CoreData
import SwiftUI

class WeatherDetailViewModel: ObservableObject {
    @Published var weather: WeatherDomainModel?
    @Published var favorites: [LocationDomainModel] = []
    @Published var isLoading: Bool = false
    @Published var error: NetworkErrorType = .none

    let location: LocationDomainModel
    private let getWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol

    var daysForecastLabel: String {
        String(
            format: "%d %@",
            WeatherContants.values.forecastDaysCount,
            WeatherContants.Strings.daysForecast
        )
    }

    var expectedWeatherForNextHourLabel: String {
        if let weather {
            return String(
                format: "%@ %@ %@. %@ %d km/h.",
                getNextHourModel(weather: weather)?.condition.text ?? .empty,
                WeatherContants.Strings.conditionsExpectedAround,
                getNextHour(weather: weather),
                WeatherContants.Strings.windGustAreUpTo,
                Int(weather.current.windKph ?? .zero)
            )
        }
        return .empty
    }

    var minTemperature: String {
        if let weather {
            return String(format: "%@: %@",
                          WeatherContants.Strings.min.capitalized,
                          WeatherUtils.getTempString(temp: weather.forecast.forecastday.first?.day.mintempC))
        }
        return .empty
    }

    var maxTemperature: String {
        if let weather {
            return String(format: "%@: %@",
                          WeatherContants.Strings.max.capitalized,
                          WeatherUtils.getTempString(temp: weather.forecast.forecastday.first?.day.maxtempC))
        }
        return .empty
    }

    var weatherLocation: String {
        if let weather {
            return String(format: "%@, %@", weather.location.name, weather.location.country)
        }
        return .empty
    }


    init(location: LocationDomainModel, getWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol) {
        self.location = location
        self.getWeatherDetailUseCase = getWeatherDetailUseCase
    }

    @MainActor
    func fetchWeatherDetail() {
        Task {
            do {
                self.error = .none
                self.isLoading = true
                let weather = try await getWeatherDetailUseCase.execute(location: location)
                self.weather = weather
                self.isLoading = false
            } catch {
                handleError(error: error)
            }
        }
    }

    private func handleError(error: Error) {
        if let error = error as? NetworkErrorType {
            self.error = error
        } else {
            self.error = .unkown(error)
        }
        self.isLoading = false
    }
}

extension WeatherDetailViewModel {
    func openMaps(latitude: Double, longitude: Double) {
        let latitudeString = String(latitude)
        let longitudeString = String(longitude)

        if let url = URL(string: "maps://?ll=\(latitudeString),\(longitudeString)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                debugPrint("Can not open Maps")
            }
        }
    }
}

// MARK: helper functions
extension WeatherDetailViewModel {
    func getNextHours(localTime: String, currents: [CurrentDomainModel]) -> [CurrentDomainModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = WeatherContants.DateFormats.dateWithTime
        let localDate = dateFormatter.date(from: localTime) ?? Date()

        let calendar = Calendar.current
        let currentDate = calendar.dateComponents([.year, .month, .day, .hour], from: localDate)

        let filteredDates = currents.compactMap { current -> CurrentDomainModel? in
            guard let dateString = current.time,
                  let date = dateFormatter.date(from: dateString) else {
                return nil
            }
            let dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: date)
            if dateComponents.year == currentDate.year,
               dateComponents.month == currentDate.month,
               dateComponents.day == currentDate.day,
               dateComponents.hour! >= currentDate.hour! {
                return current
            } else {
                return nil
            }
        }
        return filteredDates
    }

    func getNextHourModel(weather: WeatherDomainModel) -> CurrentDomainModel? {
        let nextHours = getNextHours(
            localTime: weather.location.localtime ?? .empty,
            currents: weather.forecast.forecastday.first?.hours ?? []
        ).prefix(2)
        return nextHours.last
    }

    func getNextHour(weather: WeatherDomainModel) -> String {
        guard let nextHourModel = getNextHourModel(weather: weather) else { return .empty }
        let nextHour = WeatherUtils.getHourFromDate(locationDate: weather.location.localtime ?? .empty,
                                                    dateStr: nextHourModel.time ?? .empty)
        return nextHour
    }
}
