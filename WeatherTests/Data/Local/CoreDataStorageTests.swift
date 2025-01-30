//
//  CoreDataStorageTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import CoreData
import Testing

final class CoreDataStorageTests {
    @Test func fetchAllLocations() {
        // Given
        let dataStorage = CoreDataStorage(
            context: mockContext()
        )
        // When
        let response = dataStorage.fetchAllLocations()
        // Then
        #expect(response.isEmpty)
    }

    @Test func saveLocation() {
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
            context: mockContext()
        )
        // When
        dataStorage.saveLocation(location: location)
        // Then
        let response = dataStorage.fetchAllLocations()
        #expect(response.count == 1)
        #expect(response.last?.id == 20)
    }

    @Test func deleteLocation() {
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
            context: mockContext()
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

    func mockContext() -> NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: WeatherContants.Database.dataModelName)

        let descripcion = NSPersistentStoreDescription()
        descripcion.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [descripcion]

        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("can not load the persistent container: \(error)")
            }
        }

        return persistentContainer.viewContext
    }
}
