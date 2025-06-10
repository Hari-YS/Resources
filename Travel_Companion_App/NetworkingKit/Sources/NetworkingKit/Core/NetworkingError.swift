//
//  NetworkingError.swift
//  NetworkingKit
//
//  Created by Sri on 28/05/25.
//

import Foundation

/// Describes possible errors in networking operations.

public enum NetworkingError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case unknown

    //Equatable is required here to do XCAssertEqual in tests class. So below stubs are filled accordingly
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.invalidResponse, .invalidResponse),
             (.unknown, .unknown):
            return true
        // We treat all decoding/network errors as equal, since `Error` isn't equatable
        case (.decodingError, .decodingError),
             (.networkError, .networkError):
            return true
        default:
            return false
        }
    }
}
