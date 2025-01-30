//
//  Network.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import SwiftUI
import Combine
import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T
}

public class Network: NetworkProtocol {
    public static let shared = Network()
    
    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        do {
            guard let urlCompponent = NSURLComponents(string: endPoint.urlString) else {
                throw NetworkErrorType.generalError
            }
            var items = [URLQueryItem]()
            for queryParam in endPoint.parameters {
                items.append(URLQueryItem(name: queryParam.key, value: "\(queryParam.value)"))
            }
            items = items.filter{!$0.name.isEmpty}
            if !items.isEmpty {
                urlCompponent.queryItems = items
            }
            guard let url = urlCompponent.url else {
                throw NetworkErrorType.invalidURL
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endPoint.method
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == ResponseStatusType.success.rawValue else {
                guard let errorModel = try? decoder.decode(ApiErrorDto.self, from: data) else {
                    throw NetworkErrorType.generalError
                }
                throw errorModel
            }
            guard let model = try? decoder.decode(T.self, from: data) else {
                throw NetworkErrorType.invalidData
            }
            return model
        } catch let error as ApiErrorDto {
            if error.error.code < .zero {
                throw NetworkErrorType.internetConnection
            }
            throw NetworkErrorType.error(from: error.error)
        } catch {
            throw NetworkErrorType.unkown(error)
        }
    }
}
