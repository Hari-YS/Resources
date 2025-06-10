//
//  PlacesListView.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import SwiftUI
import CoreLocation

struct PlacesListView: View {
    @StateObject var viewModel: PlacesListViewModel
    @ObservedObject var locationService: LocationService
    @State private var showItinerary = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if let location = locationService.location {
                    List(viewModel.places, id: \.placeID) { place in
                        NavigationLink(destination: PlaceDetailView(place: place)) {
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                // We could separate the whole image view as well, incase it is used in future.
                                if let photoRef = place.photos?.first?.photoReference, !photoRef.isEmpty {
                                    AsyncImageView(photoReference: photoRef, apiKey: GooglePlacesAPIConfig.shared.apiKey)
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    // Dummy fallback
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(.gray.opacity(0.5))
                                        .background(Color.gray.opacity(0.2))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(place.name)
                                        .font(.headline)
                                    if let address = place.vicinity {
                                        Text(address)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    // Uniform, one-line summary
                                    HStack(spacing: 8) {
                                        // Star and rating
                                        if let rating = place.rating {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.caption)
                                            Text(String(format: "%.1f", rating))
                                                .font(.caption)
                                        }
                                        // Separator
                                        if let rating = place.rating, place.userRatingsTotal != nil || place.types.first != nil {
                                            Text("|").font(.caption).foregroundColor(.gray)
                                        }
                                        // Number of reviews
                                        if let userRatings = place.userRatingsTotal {
                                            Text("\(userRatings) reviews")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                        // Separator
                                        if (place.userRatingsTotal != nil && place.types.first != nil) {
                                            Text("|").font(.caption).foregroundColor(.gray)
                                        }
                                        // Place type
                                        if let type = place.types.first {
                                            Text(type.capitalized)
                                                .font(.caption)
                                                .foregroundColor(.blue)
                                        }
                                    }
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                    
                    // Create Itinerary Button (Below List)
                    Button(action: { showItinerary = true }) {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("Create Itinerary")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 12)
                    .sheet(isPresented: $showItinerary) {
                        ItineraryView(places: viewModel.places, userLocation: location)
                    }
                } else {
                    ProgressView("Getting location...")
                        .frame(maxHeight: .infinity)
                }
            }
            .navigationTitle("Nearby Places")
//            .onAppear {
//                Task {
//                    if let location = locationService.location {
//                        print("Network Call made")
//                        await viewModel.fetchPlaces(at: location)
//                    }
//                }
//            }
            .task {
                if let location = locationService.location {
                    await viewModel.fetchPlaces(at: location)
                }
            }
        }
    }
}



#if DEBUG
struct PlacesListView_Previews: PreviewProvider {
    static var previews: some View {
        // Mock ViewModel
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
        let mockVM = PlacesListViewModel(fetchNearbyPlacesUseCase: .init(repository: MockPlacesRepository()))
        mockVM.places = mockPlaces
        // Mock LocationService
        let mockLocationService = LocationService()
        mockLocationService.location = CLLocationCoordinate2D(latitude: 43.6465, longitude: -79.4637)
        return PlacesListView(viewModel: mockVM, locationService: mockLocationService)
    }
}
#endif


// Interviewer: Instead of writing big preview, from Swift 5.9 Apple introduces #Preview { } . The above is added for older version compatibility.
// Views above could further be disintegrated into multiple smaller views for maintainability. Good to always have clear readable views in production ready build.
// Forsake the lengthier code above.
