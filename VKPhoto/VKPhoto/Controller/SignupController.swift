//
//  SignupController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 07.04.2022.
//

import Foundation
import UIKit

class SignupController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SignupView()
        self.view.addSubview(view)
        view.prepare()
    }
}
