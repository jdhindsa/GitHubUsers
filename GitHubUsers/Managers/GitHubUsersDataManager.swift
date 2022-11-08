//
//  GitHubUsersDataManager.swift
//  GitHubUsers
//
//  Created by Jason Dhindsa on 2022-11-08.
//

import SwiftUI

actor GitHubUsersDataManager {
    let scheme = "https"
    let host = "api.github.com"
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpointURL = generateEndpointURL(
            path: "/users/\(username)/followers",
            queryItems: [
                URLQueryItem(name: "per_page", value: "100"),
                URLQueryItem(name: "page", value: String(page))
            ]
        )
        return try await fetchData(endpoint: endpointURL)
    }
    
    func getUser(for username: String) async throws -> User {
        return try await fetchData(endpoint: generateEndpointURL(path: "/users/\(username)"))
    }
    
    func fetchData<T>(endpoint: String) async throws -> T where T: Decodable {
        guard let url = URL(string: endpoint) else { throw GUError.invalidURL }
        
        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        let httpResponse = urlResponse as! HTTPURLResponse
        guard (200..<300).contains(httpResponse.statusCode) else { throw GUError.invalidResponse }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
    
    private func generateEndpointURL(path: String, queryItems: [URLQueryItem] = []) -> String {
        URLComponents.createEndpointURL(
            scheme: scheme,
            host: host,
            path: path,
            queryItems: queryItems
        )
    }
}
