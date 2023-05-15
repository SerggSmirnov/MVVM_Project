//
//  RootNiblessView.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 15.05.2023.
//

import UIKit

class RootNiblessView: NiblessView {
    
    private var viewModel: ViewModel?
    
    private var backColor = #colorLiteral(red: 0.9796730876, green: 0.9796730876, blue: 0.9796730876, alpha: 1)
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.setTitle("Sign In", for: .normal)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(backColor, for: .normal)
        button.addTarget(viewModel, action: #selector(viewModel?.signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 10
        button.setTitle("Sign Up", for: .normal)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.setTitleColor(backColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(viewModel, action: #selector(viewModel?.signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var stackViewButtons = UIStackView()
    
    //MARK: - Init
    
    init(viewModel: ViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        
    }
    
    //MARK: - Methods
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = backColor
        addSubview(logoImageView)
        stackViewButtons = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .horizontal,
                                       spacing: 20)
        stackViewButtons.distribution = .fillEqually
        addSubview(stackViewButtons)
    }
}

//MARK: - Set Constraints

extension RootNiblessView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackViewButtons.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            stackViewButtons.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewButtons.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackViewButtons.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
