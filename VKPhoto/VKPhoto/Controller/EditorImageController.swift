//
//  EditorImageController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 05.04.2022.
//

import Foundation
import UIKit

class EditorImageController: UIViewController {
    var fullImage: ImageItem?
    var fullImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = EditorImageView()
        self.view = view
        view.prepare()
        self.fullImageView = view.fullImage
        self.fullImageView?.image = fullImage?.getImage()
    }
    
}
