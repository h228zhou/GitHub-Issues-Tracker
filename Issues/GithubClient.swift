//
//  GithubClient.swift
//  Issues
//
//  Created by Ryan Zhou on 1/22/24.
//

import Foundation

class GithubClient {
    
    enum IssueFetcherError: Error {
        case invalidURL
        case badResponse
    }
    
    func fetchIssues(state: String) async throws -> [Issues] {
        
        // https://github.com/KRTirtho/spotube
        guard let url = URL(string: "https://api.github.com/repos/KRTirtho/spotube/issues?state=\(state)") else {
            throw IssueFetcherError.invalidURL
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw IssueFetcherError.badResponse
        }
        
        // Parse the JSON data
        let decodedIssue = try decoder.decode([Issues].self, from: data)
        return decodedIssue
    }
    
}
