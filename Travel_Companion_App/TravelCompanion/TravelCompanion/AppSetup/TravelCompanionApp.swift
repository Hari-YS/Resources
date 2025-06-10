//
//  TravelCompanionApp.swift
//  TravelCompanion
//
//  Created by Sri on 09/06/25.
//

import SwiftUI
import NetworkingKit //  Framework containing NetworkingService.


@main
struct TravelCompanionApp: App {
    var body: some Scene {
        WindowGroup {
            let networkingService = NetworkingService()
            let repo = PlacesRepositoryImpl(networking: networkingService)
            let useCase = FetchNearbyPlacesUseCase(repository: repo)
            let viewModel = PlacesListViewModel(fetchNearbyPlacesUseCase: useCase)
            let locationService = LocationService()
            PlacesListView(viewModel: viewModel, locationService: locationService)
        }
    }
}


// Interviewer: For this demo, I construct dependencies inline like above for simplicity. In production, I use a composition root or DI container so dependencies are resolved in one place. This supports testing, feature growth, and environment-based swapping (like real vs. mock services). For SwiftUI, I may also use EnvironmentObjects for deeply shared dependencies.
