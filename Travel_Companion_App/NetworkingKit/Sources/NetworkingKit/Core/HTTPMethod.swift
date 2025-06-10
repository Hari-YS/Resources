//
//  HTTPMethod.swift
//  NetworkingKit
//
//  Created by Sri on 28/05/25.
//

import Foundation

/// Supported HTTP methods for requests.
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
