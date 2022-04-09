//
//  SignupController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 07.04.2022.
//

import Foundation
import UIKit

class SignupController: UIViewController {
    //MARK: - data
    var nextButtonDidTapDelegate: (() -> Void)?
    
    private var loginTextField: UITextField?
    private var passwordTextField: UITextField?

    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let view = SignupView()
        self.view.addSubview(view)
        view.prepare()
        
        self.loginTextField = view.loginTextField
        self.passwordTextField = view.passwordTextField
        
        view.nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - private functions
    
    @objc private func nextButtonDidTap() {
        if let login = loginTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !login.isEmpty,
           let password = passwordTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty {
            if login.contains(" ") || password.contains(" ") {
                let signupAlert = UIAlertController(title: "Username or password contains spaces", message: nil, preferredStyle: .alert)
                signupAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(signupAlert, animated: true, completion: nil)
            } else {
                if let _ = UserService.shared.findUser(login: login, password: password) {
                    let signupAlert = UIAlertController(title: "User with the same login and password already exists", message: nil, preferredStyle: .alert)
                    signupAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(signupAlert, animated: true, completion: nil)
                } else {
                    let newUser = UserService.User(login: login, password: password, avatar: nil, imageСollection: [])
                    UserService.shared.setActiveUserIndex(index: (UserService.shared.addUser(newUser)))
                    UserService.shared.save()
                    nextButtonDidTapDelegate?()
                }
            }
        } else {
            let signupAlert = UIAlertController(title: "Username or password is empty", message: nil, preferredStyle: .alert)
            signupAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(signupAlert, animated: true, completion: nil)
        }
    }
}
