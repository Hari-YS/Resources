//
//  MockPlacesRepository.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import Foundation
import CoreLocation

class MockPlacesRepository: PlacesRepository {
    var shouldSucceed = true
    var error: Error = URLError(.notConnectedToInternet)
    // Sample data for previews
    var samplePlaces: [Place] = [
        Place(
            name: "High Park",
            geometry: Geometry(location: Location(lat: 43.6465, lng: -79.4637)),
            photos: [Photo(photoReference: "mockPhoto")],
            placeID: "abc123",
            rating: 4.6,
            userRatingsTotal: 5216,
            types: ["park"],
            vicinity: "Toronto, ON",
            openingHours: nil,
            priceLevel: nil
        ),
        Place(
            name: "Ripley's Aquarium",
            geometry: Geometry(location: Location(lat: 43.6426, lng: -79.3871)),
            photos: nil,
            placeID: "def456",
            rating: 4.7,
            userRatingsTotal: 11000,
            types: ["aquarium"],
            vicinity: "Toronto, ON",
            openingHours: nil,
            priceLevel: nil
        )
    ]
    
    func fetchNearbyPlaces(at location: CLLocationCoordinate2D) async throws -> PlacesResponse {
        if shouldSucceed {
            return PlacesResponse(results: samplePlaces, status: "OK", nextPageToken: nil)
        } else {
            throw error
        }
    }
}


// Interviewer: Mocks can be placed inside the Feature folders too. And Repositories can easily be mocked and used for previews , testing etc.
