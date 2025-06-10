//
//  FetchNearbyPlacesUseCase.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import CoreLocation

struct FetchNearbyPlacesUseCase {
    let repository: PlacesRepository
    
    func execute(at location: CLLocationCoordinate2D) async throws -> PlacesResponse {
        try await repository.fetchNearbyPlaces(at: location)
    }
}


// Interviewer: There should never be any dependency at the Domain layer ( Business logic ).
// That is why we can see that the use case is conforming only to the interface and not the actual implementation.
// Ideally importing CoreLocation , can/should also be prevented. Forsake the use here.
// Use cases are more like Iterators in VIPER architecture.
