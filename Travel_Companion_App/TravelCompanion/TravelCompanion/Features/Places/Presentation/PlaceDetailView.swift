//
//  PlaceDetailView.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import SwiftUI
import CoreLocation

struct PlaceDetailView: View {
    let place: Place
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Photo gallery (horizontal scroll)
                if let photos = place.photos, !photos.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(photos.indices, id: \.self) { idx in
                                AsyncImageView(photoReference: photos[idx].photoReference, apiKey: GooglePlacesAPIConfig.shared.apiKey)
                                    .frame(width: 200, height: 140)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(radius: 3)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                } else {
                    // Fallback if no photos
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 120)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.vertical, 8)
                }
                
                // Main info
                Text(place.name)
                    .font(.title2)
                    .fontWeight(.bold)
                if let type = place.types.first {
                    Text(type.capitalized)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                // Rating & reviews
                HStack {
                    if let rating = place.rating {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                            .font(.subheadline)
                    }
                    if let userRatings = place.userRatingsTotal {
                        Text("(\(userRatings) reviews)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                // Description/address
                if let address = place.vicinity {
                    Text(address)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)
                }
                
                // Open in Google Maps button
                Button {
                    openInGoogleMaps(place: place)
                } label: {
                    HStack {
                        Image(systemName: "car.fill")
                        Text("Open in Google Maps")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.top, 8)
            }
            .padding()
        }
        .navigationTitle(place.name)
    }
    
    private func openInGoogleMaps(place: Place) {
        let lat = place.geometry.location.lat
        let lng = place.geometry.location.lng
        // Deep link to Google Maps app, fallback to web if not installed
        let urlString = "comgooglemaps://?daddr=\(lat),\(lng)&directionsmode=driving"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else if let webUrl = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lng)") {
            UIApplication.shared.open(webUrl)
        }
    }
}


// Interviewer: This is just a placeholder view. to show details of the places the user clicks and to be able to navigate to the place by clicking on go to maps.
// The place details are not shown due to the limitation of response (google places api) not having any details or more photos of the place.
// Further enhancement would be to use other apis like wikipedia ( or chatgpt apis ) to fetch and populate the data. But is limited here due to explanation purpose only.
