//
//  PlacesRepositoryImplTests.swift
//  TravelCompanionTests
//
//  Created by Sri on 09/06/25.
//

import XCTest
import CoreLocation
@testable import TravelCompanion
@testable import NetworkingKit

final class PlacesRepositoryImplTests: XCTestCase {
    func testFetchNearbyPlacesReturnsPlaces() async throws {
        // Prepare mock networking
        let places = [
            Place(
                name: "Mock Park",
                geometry: Geometry(location: Location(lat: 1, lng: 2)),
                photos: nil,
                placeID: "mock123",
                rating: 4.5,
                userRatingsTotal: 100,
                types: ["park"],
                vicinity: "Somewhere",
                openingHours: nil,
                priceLevel: nil
            )
        ]
        let mockData = try! JSONEncoder().encode(PlacesResponse(results: places, status: "OK", nextPageToken: nil))
        let mockNetworking = MockNetworkingService()
        mockNetworking.shouldSucceed = true
        mockNetworking.mockData = mockData

        let repo = PlacesRepositoryImpl(networking: mockNetworking)
        let location = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let result = try await repo.fetchNearbyPlaces(at: location)
        XCTAssertEqual(result.results.count, 1)
        XCTAssertEqual(result.results.first?.name, "Mock Park")
    }

    func testFetchNearbyPlacesFailure() async {
        let mockNetworking = MockNetworkingService()
        mockNetworking.shouldSucceed = false
        mockNetworking.error = NetworkingError.invalidResponse

        let repo = PlacesRepositoryImpl(networking: mockNetworking)
        do {
            _ = try await repo.fetchNearbyPlaces(at: CLLocationCoordinate2D(latitude: 1, longitude: 2))
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is NetworkingError)
        }
    }
}
