//
//  MockContext.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import CoreData

class MockContext {
    static func mockContext() -> NSManagedObjectContext {
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
