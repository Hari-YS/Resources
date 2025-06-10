////
////  PlacesModel.swift
////  TravelCompanion
////
////  Created by Sri on 09/06/25.
////

import Foundation
import CoreLocation

struct PlacesResponse: Codable {
    let results: [Place]
    let status: String
    let nextPageToken: String?
    
    enum CodingKeys: String, CodingKey {
        case results, status
        case nextPageToken = "next_page_token"
    }
}

struct Place: Codable {
    let name: String
    let geometry: Geometry
    let photos: [Photo]?
    let placeID: String
    let rating: Double?
    let userRatingsTotal: Int?
    let types: [String]
    let vicinity: String?
    let openingHours: OpeningHours?
    let priceLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, geometry, photos
        case placeID = "place_id"
        case rating
        case userRatingsTotal = "user_ratings_total"
        case types, vicinity
        case openingHours = "opening_hours"
        case priceLevel = "price_level"
    }
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Photo: Codable {
    let photoReference: String

    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}

struct OpeningHours: Codable {
    let openNow: Bool?

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}


// Interviewer: For the purpose of this demo, the models are kept limited and reserved to only few parameters.
// This is the actual business/Domain layer. Which will have no dependencies from any other layer.
// ideally the domain layer should be constructed in such a way as to be reusable outside the scope of this project also if required. Should be simple enough to isolate and place it in other project
