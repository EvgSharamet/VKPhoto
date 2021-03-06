//
//  SignupView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 07.04.2022.
//

import Foundation
import UIKit

class SignupView: UIView {
    //MARK: - data

    let vkLogo = UIImageView()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let nextButton = UIButton()
    
    private let mainStackView = UIStackView()
    private let loginLabel = UILabel()
    
    //MARK: - public functions
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private functions
    
    private func prepare() {
        self.backgroundColor = .systemGroupedBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stretch()
        setupVKLogo()
        setupMainStackView()
        setupLoginLabel()
        setupLoginTextField()
        setupPasswordTextField()
        setupNextButton()
    }
    
    private func setupVKLogo() {
        self.addSubview(vkLogo)
        vkLogo.translatesAutoresizingMaskIntoConstraints = false
        vkLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        vkLogo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        vkLogo.widthAnchor.constraint(equalToConstant: 40).isActive = true
        vkLogo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        vkLogo.layer.cornerRadius = 10
        vkLogo.layer.masksToBounds = true
        vkLogo.image = UIImage(named: "vkLogoGray")
        vkLogo.contentMode = .scaleAspectFit
    }
    
    private func setupMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.backgroundColor = .systemGroupedBackground
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 10).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
    }
    
    private func setupLoginLabel() {
        mainStackView.addArrangedSubview(loginLabel)
        loginLabel.text = "Enter your login and password:"
        loginLabel.font = UIConst.loginDescriptionFont
        loginLabel.textAlignment = .left
    }
    
    private func setupLoginTextField() {
        mainStackView.addArrangedSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -20).isActive = true
        loginTextField.layer.cornerRadius = 10
        loginTextField.setLeftPaddingPoints(20)
        loginTextField.placeholder = "Login"
        loginTextField.backgroundColor = .systemGray6
        loginTextField.textAlignment = .left
    }
    
    private func setupPasswordTextField() {
        mainStackView.addArrangedSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -20).isActive = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.setLeftPaddingPoints(20)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textAlignment = .left
    }
    
    private func setupNextButton() {
        self.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.setTitle("Register", for: .normal)
        nextButton.backgroundColor =  UIColor(
            red: 75 / 255,
            green: 116 / 255,
            blue: 163 / 255,
            alpha: 1)
        nextButton.layer.cornerRadius = 15
    }
}
