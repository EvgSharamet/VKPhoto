//
//  LoginController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    //MARK: - data
    
    var loginButtonDidTapDelegate: (() ->  Void)?
    var signupButtonDidTapDelegate: (() -> Void)?
    
    private var loginTextField: UITextField?
    private var passwordTextField: UITextField?
    private let userService: IUserService
    
    //MARK: - public functions
    
    init(userService: IUserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let view = LoginView()
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stretch()
        
        loginTextField = view.loginTextField
        passwordTextField = view.passwordTextField
    
        view.loginButton.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        view.signupButton.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
    }

    //MARK: - private functions
    
    @objc private func loginButtonDidTap() {
        if let login = loginTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !login.isEmpty,
           let password = passwordTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty {
            if let activeUserIndex = userService.findUser(login: login, password: password) {
                userService.setActiveUserIndex(index: activeUserIndex)
                userService.save()
                loginButtonDidTapDelegate?()
            } else {
                let loginAlert = UIAlertController(title: "No such user exists", message: nil, preferredStyle: .alert)
                loginAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(loginAlert, animated: true, completion: nil)
            }
        } else {
            let loginAlert = UIAlertController(title: "The username or password is incorrect", message: nil, preferredStyle: .alert)
            loginAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(loginAlert, animated: true, completion: nil)
        }
    }
    
    @objc private func signupButtonDidTap() {
        signupButtonDidTapDelegate?()
    }
}
