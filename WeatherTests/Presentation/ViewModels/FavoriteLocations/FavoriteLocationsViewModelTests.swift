//
//  FavoriteLocationsViewModelTests.swift
//  Weather
//
//  Created by Ronal Fabra Jimenez on 29/01/25.
//

@testable import Weather
import Testing
import XCTest

final class FavoriteLocationsViewModelTests: XCTestCase {

    func testLoadFavorites() {
        // Given
        let viewModel = FavoriteLocationsViewModel(context: MockContext.mockContext())
        // When
        viewModel.loadFavorites()
        // Then
        #expect(viewModel.favorites.isEmpty)
    }

    func testUpdateFavorite() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
        let viewModel = FavoriteLocationsViewModel(context: MockContext.mockContext())
        // When
        viewModel.updateFavorite(location: location)
        // Then
        #expect(viewModel.favorites.count == 1)
        XCTAssertEqual(viewModel.favorites.first?.id, location.id)
    }

    func testDeleteItem() {
        // Given
        let location = LocationDomainModel(
            id: 123,
            name: "",
            country: "",
            latitude: .zero,
            longitude: .zero,
            localtime: ""
        )
        let viewModel = FavoriteLocationsViewModel(context: MockContext.mockContext())
        let expectation = XCTestExpectation(description: "Wait for favorites is updated")
        let cancellable = viewModel.$favorites.sink { favorites in
            if favorites.count == 1 {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateFavorite(location: location)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.favorites.count == 1)
        XCTAssertEqual(viewModel.favorites.first?.id, location.id)
        viewModel.deleteItem(index: 0)
        #expect(viewModel.favorites.isEmpty)

        cancellable.cancel()
    }
}
