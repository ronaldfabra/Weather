//
//  PersistenceController.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import CoreData

struct PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: WeatherContants.Database.dataModelName)
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("can not load the persistent container: \(error)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // mock data for preview
        let newLocation = Location(context: viewContext)
        newLocation.id = 1
        newLocation.name = "Santa Marta"
        newLocation.country = "Magdalena"
        newLocation.latitude = 11.22
        newLocation.longitude = -74.18

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
