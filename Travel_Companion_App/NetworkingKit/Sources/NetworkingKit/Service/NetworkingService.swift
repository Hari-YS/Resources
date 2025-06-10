//
//  NetworkingService.swift
//  NetworkingKit
//
//  Created by Sri on 28/05/25.
//



import Foundation

/// Concrete implementation of NetworkingProtocol using URLSession.
public final class NetworkingService: NetworkingProtocol {
    
    public init() {}

    public func request<T: Decodable>(
        url: String,
        method: HTTPMethod,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkingError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.allHTTPHeaderFields = headers
        
        // Add default header if not present
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                throw NetworkingError.invalidResponse
            }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return decoded
            } catch {
                throw NetworkingError.decodingError(error)
            }
        } catch {
            throw NetworkingError.networkError(error)
        }
    }
}


extension Encodable {
    public func toJSONData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
