//
//  NetworkMock.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather

class NetworkMock<T: Decodable>: NetworkProtocol {

    var mockResponse: T? = nil

    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        if let mockResponse =  mockResponse as? T {
            return mockResponse
        } else {
            throw NetworkErrorType.invalidData
        }
    }
}
