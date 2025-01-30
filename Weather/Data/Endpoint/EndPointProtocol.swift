//
//  EndPointProtocol.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

public protocol EndPointProtocol {
    var method: String { get }
    var urlString: String { get }
    var parameters: [String: Any] { get }
}

public enum URLRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
