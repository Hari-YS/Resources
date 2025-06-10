//
//  NetworkingProtocol.swift
//  NetworkingKit
//
//  Created by Sri on 28/05/25.
//

import Foundation

/// Protocol defining networking operations for testability & modularity.
public protocol NetworkingProtocol {
    func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        body: Data?,
        headers: [String: String]?
    ) async throws -> T
}
