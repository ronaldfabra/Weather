//
//  CoreDataStorage.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import CoreData
import Foundation

class CoreDataStorage {

    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveLocation(location: LocationDomainModel) {
        let locationEntity = Location(context: context)
        locationEntity.id = Int32(location.id ?? 0)
        locationEntity.name = location.name
        locationEntity.country = location.country
        locationEntity.latitude = location.latitude
        locationEntity.longitude = location.longitude
        do {
            try context.save()
        } catch {
            debugPrint("Error saving favorite: \(error)")
        }
    }

    func fetchAllLocations() -> [LocationDomainModel] {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()

        do {
            let locations = try context.fetch(fetchRequest)
            return locations.map { location in
                LocationDomainModel(
                    id: Int(location.id),
                    name: location.name ?? .empty,
                    country: location.country ?? .empty,
                    latitude: location.latitude,
                    longitude: location.longitude,
                    localtime: .empty
                )
            }
        } catch {
            debugPrint("Error listing the locations: \(error)")
            return []
        }
    }

    func deleteLocation(location: LocationDomainModel) {
        let fetchRequest: NSFetchRequest<Location> = Location.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", location.id ?? 0)

        do {
            let results = try context.fetch(fetchRequest)
            if let objectToDelete = results.first {
                context.delete(objectToDelete)
                try context.save()
            }
        } catch {
            debugPrint("Erorr deleting favorite: \(error)")
        }
    }
}
