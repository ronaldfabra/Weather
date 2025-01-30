//
//  CoreDataStorageTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import CoreData
import Testing
import XCTest

final class CoreDataStorageTests: XCTestCase {
    func testFetchAllLocations() {
        // Given
        let dataStorage = CoreDataStorage(
            context: MockContext.mockContext()
        )
        // When
        let response = dataStorage.fetchAllLocations()
        // Then
        #expect(response.isEmpty)
    }

    func testSaveLocation() {
        // Given
        let location = LocationDomainModel(
            id: 20,
            name: "",
            country: "",
            latitude: 0.0,
            longitude: 0.0,
            localtime: nil
        )
        let dataStorage = CoreDataStorage(
            context: MockContext.mockContext()
        )
        // When
        dataStorage.saveLocation(location: location)
        // Then
        let response = dataStorage.fetchAllLocations()
        #expect(response.count == 1)
        #expect(response.last?.id == 20)
    }

    func testDeleteLocation() {
        // Given
        let location = LocationDomainModel(
            id: 20,
            name: "",
            country: "",
            latitude: 0.0,
            longitude: 0.0,
            localtime: nil
        )
        let dataStorage = CoreDataStorage(
            context: MockContext.mockContext()
        )
        // When
        dataStorage.saveLocation(location: location)
        var response = dataStorage.fetchAllLocations()
        // Then
        #expect(response.count == 1)
        dataStorage.deleteLocation(location: location)
        response = dataStorage.fetchAllLocations()
        #expect(response.isEmpty)
    }
}
