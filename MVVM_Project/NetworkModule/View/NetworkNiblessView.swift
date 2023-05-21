//
//  NetworkNiblessView.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 21.05.2023.
//

import UIKit

class NetworkNiblessView: NiblessView {
    
    // MARK: - Init
    
    init(viewModel: NetworkViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
    }
    
    // MARK: - Private properties
    
    static let cellID = "cell"
    
    private var viewModel: NetworkViewModel?
    
    private let tableView = UITableView()
    
    // MARK: - Methods
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = viewModel
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NetworkNiblessView.cellID)
        viewModel?.delegate = self
        viewModel?.getUserNames()
    }
}

// MARK: - Set Constraints

extension NetworkNiblessView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - NetworkViewModelDelegate

extension NetworkNiblessView: NetworkViewModelDelegate {
    func didLoadInitialUserNames() {
        tableView.reloadData()
    }
}
