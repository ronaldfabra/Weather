//
//  ApiErrorDto.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

struct ApiErrorDto: Codable, Error {
    let error: WeatherErrorDto
}
