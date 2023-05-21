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

final class NetworkViewModel: NSObject {
    
    public weak var delegate: NetworkViewModelDelegate?
    
    private var arrayUserNames = [String]()
    
    public func getUserNames() {
        APIClient.shared.getUsers { [weak self] arrayNames in
            self?.arrayUserNames = arrayNames
            DispatchQueue.main.async {
                self?.delegate?.didLoadInitialUserNames()
            }
        }
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
