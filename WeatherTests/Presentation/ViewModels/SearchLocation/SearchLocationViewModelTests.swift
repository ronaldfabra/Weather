//
//  SearchLocationViewModelTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class SearchLocationViewModelTests: XCTestCase {

    func testUpdateQuery() {
        // Given
        let query = "Santa Marta"
        let repository = LocationRepositoryMock()
        let searchLocationsUseCase = SearchLocationsUseCase(repository: repository)
        let viewModel = SearchLocationViewModel(searchLocationsUseCase: searchLocationsUseCase)
        let expectation = XCTestExpectation(description: "Wait for locations is updated")
        let cancellable = viewModel.$locations.sink { locations in
            if locations.count == 1 {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateQuery(query: query)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.locations.count == 1)
        #expect(viewModel.locations.first?.id == repository.mockLocationsResponse .first?.id)

        cancellable.cancel()
    }

    func testUpdateQueryWithEmptyValue() {
        // Given
        let query = ""
        let repository = LocationRepositoryMock()
        let searchLocationsUseCase = SearchLocationsUseCase(repository: repository)
        let viewModel = SearchLocationViewModel(searchLocationsUseCase: searchLocationsUseCase)
        // When
        viewModel.updateQuery(query: query)
        // Then
        #expect(viewModel.locations.isEmpty)
    }

}
