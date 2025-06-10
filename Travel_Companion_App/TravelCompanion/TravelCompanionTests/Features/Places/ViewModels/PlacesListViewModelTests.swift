//
//  PlacesListViewModelTests.swift
//  TravelCompanionTests
//
//  Created by Sri on 09/06/25.
//

import XCTest
import CoreLocation
@testable import TravelCompanion

@MainActor
final class PlacesListViewModelTests: XCTestCase {
    func testFetchPlacesSuccess() async {
        let mockRepo = MockPlacesRepository()
        mockRepo.shouldSucceed = true
        let useCase = FetchNearbyPlacesUseCase(repository: mockRepo)
        let viewModel = PlacesListViewModel(fetchNearbyPlacesUseCase: useCase)
        await viewModel.fetchPlaces(at: CLLocationCoordinate2D(latitude: 43.65, longitude: -79.38))
        XCTAssertEqual(viewModel.places.count, mockRepo.samplePlaces.count)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchPlacesFailure() async {
        let mockRepo = MockPlacesRepository()
        mockRepo.shouldSucceed = false
        mockRepo.error = URLError(.notConnectedToInternet)
        let useCase = FetchNearbyPlacesUseCase(repository: mockRepo)
        let viewModel = PlacesListViewModel(fetchNearbyPlacesUseCase: useCase)
        await viewModel.fetchPlaces(at: CLLocationCoordinate2D(latitude: 43.65, longitude: -79.38))
        XCTAssertEqual(viewModel.places.count, 0)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
