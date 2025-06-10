//
//  GooglePlacesAPIConfig.swift
//  TravelCompanion
//
//  Created by Sri on 10/06/25.
//

import Foundation

struct GooglePlacesAPIConfig { 
    let apiKey: String
    let baseURL: String
    let radius: String
    let type: String

    static let shared = GooglePlacesAPIConfig(
        apiKey: "",
        baseURL: "https://maps.googleapis.com/maps/api/place/nearbysearch/json",
        radius: "10000", // in metres.
        type: "tourist_attraction"  //"point_of_interest"
    )
}


// Interviewer: The above is for Demo purpose only. Never hardcode URLs in repositories. I centralize endpoints in a configuration struct or constants, which lets me swap environments, add new APIs, and maintain the codebase more easily. This is crucial for scaling, testing, and onboarding new developers.
