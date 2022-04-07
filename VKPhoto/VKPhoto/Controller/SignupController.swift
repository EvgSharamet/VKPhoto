//
//  SignupController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 07.04.2022.
//

import Foundation
import UIKit

class SignupController: UIViewController {
    var nextButton: UIButton?
    var loginTextField: UITextField?
    var passwordTextField: UITextField?
    public var nextButtonDidTapDelegate: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let view = SignupView()
        self.view.addSubview(view)
        view.prepare()
        
        self.nextButton = view.nextButton
        self.loginTextField = view.loginTextField
        self.passwordTextField = view.passwordTextField
        
        nextButton?.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    @objc func nextButtonDidTap() {
        if let login = loginTextField?.text, let password = passwordTextField?.text {
            if let _ = UserService.shared.findUser(login: login, password: password) {
                let signupAlert = UIAlertController(title: "User with the same login and password already exists", message: nil, preferredStyle: .alert)
                signupAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(signupAlert, animated: true, completion: nil)
            } else {
                let newUser = UserService.User(login: login, password: password, avatar: nil, imageСollection: [])
                UserService.shared.setActiveUserIndex(index: (UserService.shared.addUser(newUser)))
                nextButtonDidTapDelegate?()
            }
        } else {
            let signupAlert = UIAlertController(title: "The username or password is incorrect", message: nil, preferredStyle: .alert)
            signupAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(signupAlert, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
