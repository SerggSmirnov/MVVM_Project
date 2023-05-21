//
//  NetworkViewController.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 21.05.2023.
//

import UIKit

class NetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = NetworkViewModel()
        view = NetworkNiblessView(viewModel: viewModel)
    }
}
