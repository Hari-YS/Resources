//
//  MockNetworkingService.swift
//  TravelCompanionTests
//
//  Created by Sri on 09/06/25.
//

import Foundation
@testable import TravelCompanion
@testable import NetworkingKit

// Mock NetworkingProtocol for Repository Tests
final class MockNetworkingService: NetworkingProtocol {
    var shouldSucceed = true
    var mockData: Data?
    var error: Error = NetworkingError.invalidResponse

    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        if shouldSucceed, let data = mockData {
            return try JSONDecoder().decode(T.self, from: data)
        } else {
            throw error
        }
    }
}
