//
//  RootNiblessView.swift
//  MVVM_Project
//
//  Created by Sergei Smirnov on 15.05.2023.
//

import UIKit

class RootNiblessView: NiblessView {
    
    // MARK: - Init
    
    init(viewModel: RootViewModel) {
        super.init(frame: .zero)
        self.viewModel = viewModel
    }
    
    // MARK: - Private constants
    
    private enum UIConstants {
        static let logoWidht: CGFloat = 150
        static let logoHeight: CGFloat = 150
        static let spacing: CGFloat = 20
        static let stackInsetToLogo: CGFloat = 100
        static let stackHeight: CGFloat = 50
        static let buttonCornerRadius: CGFloat = 10
        static let buttonFontSize: CGFloat = 20
        static let backColor: UIColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        static let buttonColor: UIColor = .gray
        static let buttonTextColor: UIColor = .white
    }
    
    // MARK: - Private properties
    
    private var viewModel: RootViewModel?
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIConstants.buttonColor
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.buttonFontSize)
        button.setTitleColor(UIConstants.buttonTextColor, for: .normal)
        button.addTarget(viewModel, action: #selector(viewModel?.signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIConstants.buttonColor
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIConstants.buttonTextColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.buttonFontSize)
        button.addTarget(viewModel, action: #selector(viewModel?.signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var stackViewButtons = UIStackView()
    
    // MARK: - Methods
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        backgroundColor = UIConstants.backColor
        addSubview(logoImageView)
        stackViewButtons = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .horizontal,
                                       spacing: UIConstants.spacing)
        stackViewButtons.distribution = .fillEqually
        addSubview(stackViewButtons)
    }
}

// MARK: - Set Constraints

extension RootNiblessView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: UIConstants.logoHeight),
            logoImageView.widthAnchor.constraint(equalToConstant: UIConstants.logoWidht),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackViewButtons.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                                  constant: UIConstants.stackInsetToLogo),
            stackViewButtons.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                      constant: UIConstants.spacing),
            stackViewButtons.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -UIConstants.spacing),
            stackViewButtons.heightAnchor.constraint(equalToConstant: UIConstants.stackHeight)
        ])
    }
}
