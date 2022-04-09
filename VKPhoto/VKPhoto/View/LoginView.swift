//
//  LoginView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    //MARK: - data
    
    let loginLabel = UILabel()
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let signupButton = UIButton()
    
    private let vkLogo = UIImageView()
    private let mainStackView = UIStackView()
    private let signupLabel = UILabel()
    
    //MARK: - internal functions
    
    func prepare() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stretch()
        setupVKLogo()
        setupMainStackView()
        setupLoginLabel()
        setupLoginTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupSignupButton()
        setupSignupLabel()
    }
    
    //MARK: - private functions
    
    private func setupVKLogo() {
        self.addSubview(vkLogo)
        vkLogo.translatesAutoresizingMaskIntoConstraints = false
        vkLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        vkLogo.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        vkLogo.widthAnchor.constraint(equalToConstant: 80).isActive = true
        vkLogo.heightAnchor.constraint(equalToConstant: 80).isActive = true
        vkLogo.layer.cornerRadius = 20
        vkLogo.layer.masksToBounds = true
        vkLogo.image = UIImage(named: "vkLogo")
        vkLogo.contentMode = .scaleAspectFit
    }
    
    private func setupMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.backgroundColor = .white
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 10
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 10).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        mainStackView.backgroundColor = .white
    }
    
    private func setupLoginLabel() {
        mainStackView.addArrangedSubview(loginLabel)
        loginLabel.text = "Sign in to VKPhoto"
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
        loginTextField.textColor = .black
    }
    
    private func setupPasswordTextField() {
        mainStackView.addArrangedSubview(passwordTextField)
        passwordTextField.placeholder = "Password"
        passwordTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -20).isActive = true
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.setLeftPaddingPoints(20)
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textAlignment = .left
        passwordTextField.textColor = .black
    }
    
    private func setupLoginButton() {
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UIColor(
            red: 75 / 255,
            green: 116 / 255,
            blue: 163 / 255,
            alpha: 1)
        loginButton.layer.cornerRadius = 15
    }
    
    private func setupSignupButton() {
        self.addSubview(signupButton)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signupButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        signupButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        signupButton.setTitle("Sign Up", for: .normal)
        signupButton.backgroundColor = UIColor(
            red: 116 / 255,
            green: 163 / 255,
            blue: 76 / 255,
            alpha: 1)
        signupButton.layer.cornerRadius = 15
    }
    
    private func setupSignupLabel() {
        self.addSubview(signupLabel)
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        signupLabel.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -10).isActive = true
        signupLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        signupLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        signupLabel.widthAnchor.constraint(equalTo: signupButton.widthAnchor).isActive = true
        signupLabel.text = "Don't have an account yet?"
        signupLabel.textAlignment = .center
        signupLabel.font = UIConst.signupDescriptionFont
        signupLabel.textColor = .lightGray
    }
    
}
