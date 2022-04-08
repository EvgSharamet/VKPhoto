//
//  MainNavigationController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageCatalogWindow = ImageCatalogController()
        imageCatalogWindow.settingsButtonDidTapDelegate = goToSettings
        setViewControllers([imageCatalogWindow], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthorization()
    }
    
    //MARK: - private functions
    
    private func goToSettings() {
        let settingsWindow = SettingsController()
        settingsWindow.logoutButtonDidTapDelegate = logoutOfSystem
        pushViewController(settingsWindow, animated: true)
    }
    
    private func logoutOfSystem() {
        popToRootViewController(animated: true)
        checkAuthorization()
    }
    
    private func checkAuthorization() {
        let activeUserIndex = UserService.shared.getActiveUserIndex()
        
        if activeUserIndex == nil {
            let loginWindow = LoginController()
            loginWindow.modalPresentationStyle = .fullScreen
            loginWindow.loginButtonDidTapDelegate = onUserAuthorized
            loginWindow.signupButtonDidTapDelegate = {
                let signupWindow = SignupController()
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
