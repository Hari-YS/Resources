//
//  ItineraryView.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import SwiftUI
import CoreLocation

struct ItineraryView: View {
    let places: [Place]
    let userLocation: CLLocationCoordinate2D
    
    var body: some View {
        List {
            Section(header: Text("Visit In Order")) {
                ForEach(places, id: \.placeID) { place in
                    VStack(alignment: .leading) {
                        Text(place.name).bold()
                        if let address = place.vicinity {
                            Text(address)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        if let rating = place.rating {
                            Text(String(format: "Rating: %.1f", rating))
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .navigationTitle("Itinerary")
    }
}


#if DEBUG
struct ItineraryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPlaces = [
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
            )
        ]
        ItineraryView(places: mockPlaces, userLocation: CLLocationCoordinate2D(latitude: 43.6465, longitude: -79.4637))
    }
}
#endif


// Interviewer: The goal of this view is to show the user a ready made Iternary or route map based on the filters that the user selects. Logic reserved as part of future enhancements :)

// Interviewer: Instead of writing big preview, from Swift 5.9 Apple introduces #Preview { } . The above is added for older version compatibility.
