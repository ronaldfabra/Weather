//
//  DependencyContainer.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 28/01/25.
//

import CoreData

protocol DependencyContainerProtocol {
    func makeSearchLocationViewModel() -> SearchLocationViewModel
    func makeWeatherDetailViewModel(location: LocationDomainModel) -> WeatherDetailViewModel
    func makeFavoriteLocationsViewModel() -> FavoriteLocationsViewModel
}

class DependencyContainer: DependencyContainerProtocol {

    static let shared: DependencyContainerProtocol = DependencyContainer()

    lazy var weatherRepository: WeatherRepositoryProtocol = {
        return WeatherRepository(network: Network.shared)
    }()

    lazy var locationRepository: LocationRepositoryProtocol = {
        return LocationRepository(network: Network.shared)
    }()

    lazy var getWeatherDetailUseCase: GetWeatherDetailUseCaseProtocol = {
        return GetWeatherDetailUseCase(repository: weatherRepository)
    }()
    
    lazy var searchLocationsUseCase: SearchLocationsUseCaseProtocol = {
        return SearchLocationsUseCase(repository: locationRepository)
    }()

    func makeSearchLocationViewModel() -> SearchLocationViewModel {
        return SearchLocationViewModel(
            searchLocationsUseCase: searchLocationsUseCase
        )
    }

    func makeWeatherDetailViewModel(location: LocationDomainModel) -> WeatherDetailViewModel {
        return WeatherDetailViewModel(
            location: location,
            getWeatherDetailUseCase: getWeatherDetailUseCase
        )
    }

    func makeFavoriteLocationsViewModel() -> FavoriteLocationsViewModel {
        return FavoriteLocationsViewModel(context: PersistenceController.shared.container.viewContext)
    }
}
