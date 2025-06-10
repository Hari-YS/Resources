//
//  PlacesRepositoryImpl.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import NetworkingKit
import CoreLocation

final class PlacesRepositoryImpl: PlacesRepository {
    private let networking: NetworkingProtocol
    private let apiConfig: GooglePlacesAPIConfig

    init(networking: NetworkingProtocol, apiConfig: GooglePlacesAPIConfig = .shared) {
        self.networking = networking
        self.apiConfig = apiConfig
    }

    func fetchNearbyPlaces(at location: CLLocationCoordinate2D) async throws -> PlacesResponse {
        let urlString = "\(apiConfig.baseURL)?location=\(location.latitude),\(location.longitude)&radius=\(apiConfig.radius)&type=\(apiConfig.type)&key=\(apiConfig.apiKey)"
        return try await networking.request(
            url: urlString,
            method: .get,
            body: nil,
            headers: nil
        )
    }
}

// Interviewer: Its the Data layers responsibility to fetch data from various sources and give it back to UI. Be it from server or database or anyother datasource. Data layer can have dependency on business/Domain layer as per dependency rule.
//Note in above urlString is constructed here just for demo purpose. It becomes a request parameter in real time, thereby the code is more simpler and easy to understand.

