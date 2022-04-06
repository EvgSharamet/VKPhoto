//
//  LoginController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class LoginController: UIViewController {
    public var loginButtonDidTapDelegate : (() ->  Void)?
    
    var loginTextField: UITextField?
    var passwordTextField: UITextField?
    var loginButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = LoginView()
        self.view.addSubview(view)
        view.prepare()
        
        loginTextField = view.loginTextField
        passwordTextField = view.passwordTextField
        loginButton = view.loginButton
    
        loginButton?.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
    }
    
    @objc func loginButtonDidTap() {
        loginButtonDidTapDelegate?()
    }
}
