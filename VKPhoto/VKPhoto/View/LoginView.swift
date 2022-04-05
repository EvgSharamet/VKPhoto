//
//  LoginView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let loginTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    
    func prepare() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stretch()
        self.backgroundColor = .white
        
        let mainStackView = UIStackView()
        self.addSubview(mainStackView)
        mainStackView.backgroundColor = .white
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fillEqually
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.center(vertically: true, horizontally: true)
        mainStackView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        mainStackView.backgroundColor = .white
        
        let vkLogo = UIImageView()
        mainStackView.addArrangedSubview(vkLogo)
        vkLogo.image = UIImage(named: "vkLogo")
        vkLogo.contentMode = .scaleAspectFit
        
        let loginLabel = UILabel()
        mainStackView.addArrangedSubview(loginLabel)
        loginLabel.text = "LOGIN:"
        loginLabel.font = UIConst.logPasFont
        loginLabel.textAlignment = .left
        
        mainStackView.addArrangedSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -20).isActive = true
        loginTextField.layer.cornerRadius = 20
        loginTextField.text = "LOGIN_TEXT"
        loginTextField.backgroundColor = .systemGray6
        loginTextField.textAlignment = .left
        loginTextField.textColor = .lightGray
        
        let passwordLabel = UILabel()
        mainStackView.addArrangedSubview(passwordLabel)
        passwordLabel.text = "PASSWORD:"
        passwordLabel.font = UIConst.logPasFont
        passwordLabel.textAlignment = .left

        mainStackView.addArrangedSubview(passwordTextField)
        passwordTextField.text = "PASSWORD_TEXT"
        passwordTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -20).isActive = true
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textAlignment = .left
        passwordTextField.textColor = .lightGray
        
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.center(vertically: false, horizontally: true)
        loginButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UIColor(
            red: 75 / 255,
            green: 116 / 255,
            blue: 163 / 255,
            alpha: 1)
        loginButton.layer.cornerRadius = 10
    }
    
}