//
//  NetworkViewModel.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 20.05.2023.
//

import UIKit
import Combine

protocol NetworkViewModelDelegate: AnyObject {
    func didLoadInitialUserNames()
}

final class NetworkViewModel: NSObject, ObservableObject {
    
    var arrayUserNames = [String]()
    
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
                self?.arrayUserNames = userNames.map { $0.name }
                self?.delegate?.didLoadInitialUserNames()
            }
            .store(in: &cancellables)
    }
}

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

