//
//  LocationEndpoint.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

enum LocationEndpoint {
    case search(String)
}

extension LocationEndpoint: EndPointProtocol {
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
        case .search:
            return "search.json"
        }
    }
    
    var method: String {
        return URLRequestMethod.get.rawValue
    }
    
    var urlString: String {
        switch self {
        case .search:
            return "\(baseUrl)/\(apiVersion)/\(relativeURL)"
        }
    }
    
    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .search(let query):
            params[WeatherContants.WeatherURL.Params.key] = apiKey
            params[WeatherContants.WeatherURL.Params.queryKey] = query
        }
        return params
    }
}
