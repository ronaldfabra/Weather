//
//  NetworkErrorType.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

enum NetworkErrorType: LocalizedError, Equatable {
    case invalidURL
    case invalidApiKey
    case invalidParams
    case invalidData
    case internetConnection
    case generalError
    case unkown(Error)
    case none
    
    static func == (lhs: NetworkErrorType, rhs: NetworkErrorType) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
    
    var errorDescription: String {
        switch self {
        case .invalidURL: WeatherContants.Strings.NetworkError.invalidURL
        case .invalidApiKey: WeatherContants.Strings.NetworkError.invalidToken
        case .invalidParams: WeatherContants.Strings.NetworkError.serverError
        case .invalidData: WeatherContants.Strings.NetworkError.invalidData
        case .internetConnection: WeatherContants.Strings.NetworkError.internetConnection
        case .generalError: WeatherContants.Strings.NetworkError.general
        case .unkown(let error): error.localizedDescription
        case .none: .empty
        }
    }
    
    var errorIcon: String {
        switch self {
        case .invalidURL: WeatherContants.Icons.notFound
        case .invalidApiKey: WeatherContants.Icons.generalError
        case .invalidParams: WeatherContants.Icons.generalError
        case .invalidData: WeatherContants.Icons.generalError
        case .internetConnection: WeatherContants.Icons.notNetworkConnection
        case .generalError: WeatherContants.Icons.generalError
        case .unkown(_): WeatherContants.Icons.generalError
        case .none: WeatherContants.Icons.generalError
        }
    }
    
    static func error(from error: WeatherErrorDto) -> NetworkErrorType {
        switch error.code {
        case ResponseStatusType.invalidParams.rawValue: NetworkErrorType.invalidParams
        case ResponseStatusType.invalidURL.rawValue: NetworkErrorType.invalidURL
        case  ResponseStatusType.noApiKeyParam.rawValue, ResponseStatusType.invalidApiKey.rawValue: NetworkErrorType.invalidApiKey
        default: NetworkErrorType.unkown(error)
        }
    }
}
