//
//  NetworkManager.swift
//  GitHubRepositoryApp
//
//  Created by Rajeswaran on 17/01/22.
//

import Foundation

struct NetworkManager {
    
    static func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T,Error>) -> Void) {
        guard let url = URL(string: urlString) else { return } // or throw an error
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let err = error {
                print("Failed to fetch data:", err)
                DispatchQueue.main.async {completion(.failure(err)); return}
            }
            guard let responseData = data else { return }
            do {
                let parsedObj = try JSONDecoder().decode(T.self, from: responseData)
                DispatchQueue.main.async { completion(.success(parsedObj)) }
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                DispatchQueue.main.async { completion(.failure(jsonErr))}
            }
            
        }.resume()
    }
}


