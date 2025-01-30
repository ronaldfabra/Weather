//
//  WeatherContants.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

struct WeatherContants {
    struct WeatherURL {
        static let baseURL = "https://api.weatherapi.com"
        static let apiVerion = "v1"

        struct Params {
            static let key = "key"
            static let queryKey = "q"
            static let daysKay = "days"
        }
    }

    struct Strings {
        struct NetworkError {
            static let invalidURL = "The url seems to be incorrect, try again later."
            static let serverError = "Internal server error, try again later."
            static let invalidData = "Error in the data obtained, try again later."
            static let internetConnection = "The internet connection appears to be offline."
            static let general = "System error, try again later."
            static let invalidToken = "Please check your authorization token and try again later."
        }

        static let now = "now"
        static let today = "today"
        static let favorite = "Favorite"
        static let favorites = "Favorites"
        static let location = "Location"
        static let searchLocation = "Search Location"
        static let appName = "Weather"
        static let daysForecast = "DAYS FORECAST"
        static let tryAgain = "Try Again"
        static let conditionsExpectedAround = "conditions expected around"
        static let windGustAreUpTo = "Wind gust are up to"
        static let min = "min"
        static let max = "max"

        struct EmptyState {
            struct Favorites {
                static let title = "No favorites yet"
                static let message = "Add your favorite locations to see the weather forecast."
                static let addFavoriteHelper = "Browse our collection of locations, go to detail item and click on"
                static let button = "button."
            }

            struct Search {
                static let title = "Search for your favorite location and you will find details about its weather status."
            }
        }
    }

    struct Images {
        static let location = "location"
        static let sunny = "sunny"
        static let cloudy = "cloudy"
        static let mist = "mist"
        static let rain = "rain"
        static let snow = "snow"
        static let blizzard = "blizzard"
        static let thundery = "thundery"
        static let clear = "clear"
    }

    struct Icons {
        static let favorite = "star.fill"
        static let notFavorite = "star"
        static let location = "location"
        static let search = "magnifyingglass"
        static let appLogo = "InstaflixIcon"
        static let notNetworkConnection = "wifi.slash"
        static let notFound = "exclamationmark.triangle"
        static let generalError = "xmark.octagon"
        static let sun = "sun.max.fill"
    }

    struct Dimens {
        static let spacing10 = 10.0
        static let spacing20 = 20.0
        static let spacing50 = 50.0
    }

    struct values {
        static let forecastDaysCount = 3
    }

    struct Database {
        static let dataModelName = "Weather"
    }

    struct DateFormats {
        static let date = "yyyy-MM-dd"
        static let dateWithTime = "yyyy-MM-dd HH:mm"
        static let time = "hh:mm a"
        static let day = "EEEE"
    }
}
