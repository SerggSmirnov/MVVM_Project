//
//  UserNamesRequest.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 23.05.2023.
//

import Foundation

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
    typealias Response = UsersData
    
    var method: HTTPMethod { .GET }
    var path: String { "/users" }
    var contentType: String { "" }
    var additionalHeaders: [String: String] { [:] }
    var pathComponents: String? { nil }
    var body: Data? { nil }
    
    func handle(response: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: response)
    }
}
