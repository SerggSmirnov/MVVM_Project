//
//  ViewController.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 15.05.2023.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = RootViewModel()
        view = RootNiblessView(viewModel: viewModel)
    }
}

