//
//  ViewController.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 15.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ViewModel()
        view = RootNiblessView(viewModel: viewModel)
    }


}

