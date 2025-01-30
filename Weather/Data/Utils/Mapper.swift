//
//  Mapper.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

class Mapper<T, U> {
    func mapValue(response: T) -> U {
        fatalError("Subclasses need to implement the `mapValue` method.")
    }

    init() {}
}
