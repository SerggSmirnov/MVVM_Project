//
//  NetworkViewModel.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import UIKit

protocol NetworkViewModelDelegate: AnyObject {
    func didLoadInitialUserNames()
}
//
//final class NetworkViewModel: NSObject {
//
//    public weak var delegate: NetworkViewModelDelegate?
//
//    private var arrayUserNames = [String]()
//
//    public func getUserNames() {
//        APIClient.shared.getUsers { [weak self] arrayNames in
//            self?.arrayUserNames = arrayNames
//            DispatchQueue.main.async {
//                self?.delegate?.didLoadInitialUserNames()
//            }
//        }
//    }
//}
//
// MARK: - UITableViewDataSource

extension NetworkViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayUserNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NetworkNiblessView.cellID) else { return UITableViewCell() }
        cell.textLabel?.text = arrayUserNames[indexPath.row]
        return cell
    }
}

import Combine

final class NetworkViewModel: NSObject, ObservableObject {
    @Published var arrayUserNames = [String]()
    
    private var cancellables = Set<AnyCancellable>()
    
    public weak var delegate: NetworkViewModelDelegate?
    
    func getUserNames() {
        let request = UserNamesRequest()
        
        APIClient.shared.publisherForRequest(request)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("API request error: \(error)")
                }
            } receiveValue: { [weak self] userNames in
                self?.arrayUserNames = userNames.users.map { $0.name }

                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialUserNames()
                }
            }
            .store(in: &cancellables)
    }
}


