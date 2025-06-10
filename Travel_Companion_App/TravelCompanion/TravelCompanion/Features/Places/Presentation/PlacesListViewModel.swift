//
//  PlacesListViewModel.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import Foundation
import CoreLocation

@MainActor
final class PlacesListViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var nextPageToken: String?

    private let fetchNearbyPlacesUseCase: FetchNearbyPlacesUseCase

    init(fetchNearbyPlacesUseCase: FetchNearbyPlacesUseCase) {
        self.fetchNearbyPlacesUseCase = fetchNearbyPlacesUseCase
    }

    func fetchPlaces(at location: CLLocationCoordinate2D) async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await fetchNearbyPlacesUseCase.execute(at: location)
            self.places = response.results
            self.nextPageToken = response.nextPageToken
        } catch {
            errorMessage = error.localizedDescription
            print("errorMessage: \(String(describing: errorMessage))")
        }
        isLoading = false
    }
}


// Interviewer: The use of viewModel ideally helps in scalability and creating separation of concerns further.
// Note that MVVM is incorporated only in the presentation layer. ( Also a good and suggested approach )
// Presentation layer could further have two folders. One for ViewModels and other for views.
// Even in above it is older practise to make viwModel to conform to ObservableObject and use @Published on every paramenter.
// Latest swift syntax allows the use of @Observable on class objects and completely eliminate the requirement of adding @Published.
