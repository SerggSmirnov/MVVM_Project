//
//  APIClient.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import Foundation
import Combine

final class APIClient {
    
    static let shared = APIClient()
    
    private let baseURLString = "https://appnestradamus.herokuapp.com/api"
    
    func publisherForRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        
        let urlString = baseURLString + request.path
        let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        guard let url = URL(string: urlString) else { return Fail(error: error).eraseToAnyPublisher() }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode
                    guard (200...299).contains(statusCode) else {
                        throw NSError(domain: "HTTP Error", code: statusCode, userInfo: nil)
                    }
                }
                return data
            }
            .decode(type: T.Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        return task
    }
}
