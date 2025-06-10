//
//  PlacesRepository.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import CoreLocation

protocol PlacesRepository {
    func fetchNearbyPlaces(at location: CLLocationCoordinate2D) async throws -> PlacesResponse
}


// Interviewer: This is just an interface. As part of dependency inversion and CLEAN principles, the domain will conform to only the interface rather than the actual implementation.
