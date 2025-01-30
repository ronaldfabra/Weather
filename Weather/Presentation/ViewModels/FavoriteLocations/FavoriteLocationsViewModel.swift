//
//  FavoriteLocationsViewModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import CoreData
import Foundation

class FavoriteLocationsViewModel: ObservableObject {
    @Published var favorites: [LocationDomainModel] = []
    private let coreDataStorage: CoreDataStorage
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        self.coreDataStorage = CoreDataStorage(context: context)
        loadFavorites()
    }

    func loadFavorites() {
        favorites = coreDataStorage.fetchAllLocations()
    }

    func deleteItem(from offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let location = favorites[index]
        updateFavorite(location: location)
    }

    func updateFavorite(location: LocationDomainModel) {
        if isFavorite(location: location) {
            coreDataStorage.deleteLocation(location: location)
        } else {
            coreDataStorage.saveLocation(location: location)
        }
        loadFavorites()
    }

    func isFavorite(location: LocationDomainModel) -> Bool {
        favorites.contains(where: { $0.id == location.id })
    }
}
