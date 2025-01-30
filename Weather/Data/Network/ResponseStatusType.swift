//
//  ResponseStatusType.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

enum ResponseStatusType: Int {
    case success = 200
    case unauthorized = 403
    case noApiKeyParam = 1002
    case invalidParams = 1003
    case invalidURL = 1005
    case invalidApiKey = 2008
}
