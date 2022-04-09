//
//  MainNavigationController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    //MARK: - data
    
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
        let imageCatalogWindow = ImageCatalogController(userService: userService)
        imageCatalogWindow.settingsButtonDidTapDelegate = goToSettings
        setViewControllers([imageCatalogWindow], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthorization()
    }
    
    //MARK: - private functions
    
    private func goToSettings() {
        let settingsWindow = SettingsController(userService: userService)
        settingsWindow.logoutButtonDidTapDelegate = logoutOfSystem
        pushViewController(settingsWindow, animated: true)
    }
    
    private func logoutOfSystem() {
        popToRootViewController(animated: true)
        checkAuthorization()
    }
    
    private func checkAuthorization() {
        let activeUserIndex = userService.getActiveUserIndex()
        
        if activeUserIndex == nil {
            let loginWindow = LoginController(userService: userService)
            loginWindow.modalPresentationStyle = .fullScreen
            loginWindow.loginButtonDidTapDelegate = onUserAuthorized
            loginWindow.signupButtonDidTapDelegate = {
                let signupWindow = SignupController(userService: self.userService)
                signupWindow.nextButtonDidTapDelegate = self.onUserAuthorized
                loginWindow.present(signupWindow, animated: true)
            }
            present(loginWindow, animated: true)
        }
    }
    
    private func onUserAuthorized() {
        dismiss(animated: true) 
    }
}
