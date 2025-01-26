//
//  NetworkManager.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation

enum NetworkError : Error {
    case urlError
    case responseProblem
    case decodingProblem
    case failureMessage(message : String)
}


enum Endpoint {
    case fetchProfileMatches
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    var baseUrl: String {
        return "https://randomuser.me/api/?results=10"
    }
    var url: URL? {
        guard let url = URL(string: baseUrl) else { return nil }
        return url
    }
}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func request<T: Codable>(resultType: T.Type, endpoint: Endpoint, completionHandler: @escaping (Result<T,NetworkError>) -> Void) {
        guard let url = endpoint.url else { completionHandler(.failure(.urlError)); return }
        var requestUrl = URLRequest(url: url)
        requestUrl.httpMethod = endpoint.method
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            guard let jsonData = responseData , let urlResponse = httpUrlResponse as? HTTPURLResponse else {
                completionHandler(.failure(.responseProblem))
                return
            }
            if !(200..<300).contains(urlResponse.statusCode) {
                completionHandler(.failure(.failureMessage(message: "Server returned error code \(urlResponse.statusCode)")))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                completionHandler(.success(result))
            } catch let error {
                debugPrint("error occured while decoding = \(error.localizedDescription)")
                completionHandler(.failure(.decodingProblem))
            }
        }.resume()
    }
}
