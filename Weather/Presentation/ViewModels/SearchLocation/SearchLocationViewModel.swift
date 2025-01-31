//
//  SearchLocationViewModel.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 27/01/25.
//

import Combine
import Foundation

class SearchLocationViewModel: ObservableObject {
    @Published var locations: [LocationDomainModel] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()
    private var querySubject = PassthroughSubject<String, Never>()

    private let searchLocationsUseCase: SearchLocationsUseCaseProtocol

    init(searchLocationsUseCase: SearchLocationsUseCaseProtocol) {
        self.searchLocationsUseCase = searchLocationsUseCase
        querySubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                Task {
                    await self.searchLocation(query: query)
                }
            }
            .store(in: &cancellables)
    }

    @MainActor
    private func searchLocation(query: String) {
        if query.isEmpty {
            self.locations = []
        } else {
            Task {
                #if DEBUG
                self.locations = [.init(id: 0,
                                        name: "San francisco",
                                        country: "Estados Unidos",
                                        latitude: 0.0,
                                        longitude: 0.0,
                                        localtime: "")]
                #else
                self.isLoading = true
                do {
                    let locations = try await searchLocationsUseCase.execute(query: query)
                    self.locations = locations
                    self.isLoading = false
                } catch {
                    self.error = error
                    self.isLoading = false
                }
                #endif
            }
        }
    }
}

extension SearchLocationViewModel {
    func updateQuery(query: String) {
        querySubject.send(query)
    }
}
