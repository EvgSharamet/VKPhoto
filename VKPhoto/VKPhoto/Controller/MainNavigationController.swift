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
        let loginWindow = LoginController()
        loginWindow.loginButtonDidTapDelegate = loginInSystem
        pushViewController(loginWindow, animated: true)
    }
    
    func loginInSystem() {
        let imageCatalogWindow = ImageCatalogController()
        imageCatalogWindow.settingsButtonDidTapDelegate = goToSettings
        imageCatalogWindow.getImageDelegate = goToEditorImage
        pushViewController(imageCatalogWindow, animated: true)
    }
    
    func goToEditorImage(image: ImageItem?) {
        let editorWindow = EditorImageController()
        editorWindow.fullImage = image
        pushViewController(editorWindow, animated: true)
    }
    
    func goToSettings() {
        let settingsWindow = SettingsController()
        pushViewController(settingsWindow, animated: true)
    }
}
