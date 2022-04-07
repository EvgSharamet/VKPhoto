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
        loginButtonDidTapDelegate?()
    }
    
    @objc func signupButtonDidTap() {
        signupButtonDidTapDelegate?()
    }
}
