//
//  MovieEndpoint.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

enum WeatherEndpoint {
    case weatherDetail(Double, Double, Int)
}

extension WeatherEndpoint: EndPointProtocol {
    var baseUrl: String {
        WeatherContants.WeatherURL.baseURL
    }
    
    var apiVersion: String {
        WeatherContants.WeatherURL.apiVerion
    }
    
    var apiKey: String {
        WeatherUtils.getApiKey()
    }
    
    var relativeURL: String {
        switch self {
        case .weatherDetail:
            return "forecast.json"
        }
    }
    
    var method: String {
        return URLRequestMethod.get.rawValue
    }
    
    var urlString: String {
        switch self {
        case .weatherDetail:
            return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .weatherDetail(let latitude, let longitude, let days):
            params[WeatherContants.WeatherURL.Params.key] = apiKey
            params[WeatherContants.WeatherURL.Params.queryKey] = "\(latitude),\(longitude)"
            params[WeatherContants.WeatherURL.Params.daysKay] = days
        }
        return params
    }
}
