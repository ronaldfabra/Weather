//
//  DTOProtocol.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import Foundation

protocol DTOProtocolDecodable: Decodable & DomainModelable {}
protocol DTOProtocol: Codable & DomainModelable {}

protocol DomainModelable {
    associatedtype DomainModel

    func toDomain() throws -> DomainModel
}

extension Array where Element: DomainModelable {
    func toDomain() throws -> [Element.DomainModel] {
        try map { try $0.toDomain() }
    }
}
