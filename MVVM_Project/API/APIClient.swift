//
//  APIClient.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    private let urlString = "https://appnestradamus.herokuapp.com/api/users/"
    
    func getUsers(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            if let userData = try? JSONDecoder().decode(UsersData.self, from: data) {
                var userNameArray = [String]()
                userData.forEach({ user in
                    userNameArray.append(user.name)
                })
                completion(userNameArray)
            } else {
                print("Fail decoding")
            }
        }
        task.resume()
    }
}
