//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(_ error: String)
    case invalidStatus
    case decodingFailed(DecodingError)
    case invalidStatusCode
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getApiRequest<T: Codable>(
        url: String,
        method: HTTPMethod = .get,
        model: T.Type
    ) async throws -> T {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL(url)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
                
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidStatus
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode
        }
        
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        } catch let error as DecodingError {
            throw NetworkError.decodingFailed(error)
        } catch let error as URLError {
            throw NetworkError.invalidURL("URl Error happened: \(error.localizedDescription)")
        }
    }
}
