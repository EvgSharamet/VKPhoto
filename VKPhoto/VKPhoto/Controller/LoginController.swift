//
//  LoginController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    public var loginButtonDidTapDelegate: (() ->  Void)?
    public var signupButtonDidTapDelegate: (() -> Void)?
    
    var loginTextField: UITextField?
    var passwordTextField: UITextField?
    var loginButton: UIButton?
    var signupButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let view = LoginView()
        self.view.addSubview(view)
        view.prepare()
        
        loginTextField = view.loginTextField
        passwordTextField = view.passwordTextField
        loginButton = view.loginButton
        signupButton = view.signupButton
    
        loginButton?.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        signupButton?.addTarget(self, action: #selector(signupButtonDidTap), for: .touchUpInside)
    }

    @objc func loginButtonDidTap() {
        if let login = loginTextField?.text, let password = passwordTextField?.text {
            if let activeUserIndex = UserService.shared.findUser(login: login, password: password) {
                UserService.shared.setActiveUserIndex(index: activeUserIndex)
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
    
    @objc func signupButtonDidTap() {
        signupButtonDidTapDelegate?()
    }
}
