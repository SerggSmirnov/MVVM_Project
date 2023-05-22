//
//  APIClient.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import Foundation

//class APIClient {
//
//    static let shared = APIClient()
//
//    private let urlString = "https://appnestradamus.herokuapp.com/api/users/"
//
//    func getUsers(completion: @escaping ([String]) -> Void) {
//        guard let url = URL(string: urlString) else { return }
//        let request = URLRequest(url: url)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            if let userData = try? JSONDecoder().decode(UsersData.self, from: data) {
//                var userNameArray = [String]()
//                userData.forEach({ user in
//                    userNameArray.append(user.name)
//                })
//                completion(userNameArray)
//            } else {
//                print("Fail decoding")
//            }
//        }
//        task.resume()
//    }
//}


import Combine

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest: AnyObject {
    associatedtype Response: Decodable
    var method: HTTPMethod { get }
    var path: String { get }
    var contentType: String { get }
    var additionalHeaders: [String: String] { get }
    var pathComponents: String? { get }
    var body: Data? { get }
    func handle(response: Data) throws -> Response
}

class UserNamesRequest: APIRequest {
    typealias Response = UserNamesResponse
    
    var method: HTTPMethod { .GET }
    var path: String { "/users" }
    var contentType: String { "application/json" }
    var additionalHeaders: [String: String] { [:] }
    var pathComponents: String? { nil }
    var body: Data? { nil }
    
    func handle(response: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: response)
    }
}

final class APIClient {
    static let shared = APIClient()
    private let baseURLString = "https://appnestradamus.herokuapp.com/api"
    private let session: URLSession
    
    private init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func publisherForRequest<T: APIRequest>(_ request: T) -> AnyPublisher<T.Response, Error> {
        guard let url = buildURL(for: request) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        request.additionalHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        urlRequest.httpBody = request.body
        
        return session.dataTaskPublisher(for: urlRequest)
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
    }
    
    private func buildURL<T: APIRequest>(for request: T) -> URL? {
        let urlString = baseURLString + request.path
        guard let components = URLComponents(string: urlString) else {
            return nil
        }
        
        var url = components.url!
        if let pathComponents = request.pathComponents {
            url.appendPathComponent(pathComponents)
        }
        
        return url
    }
}
