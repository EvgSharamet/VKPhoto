//
//  EditorImageView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 05.04.2022.
//

import Foundation
import UIKit

class EditorImageView: UIView {
    let fullImage = UIImageView()
    
    func prepare() {
        self.backgroundColor = .white
        
        self.addSubview(fullImage)
        fullImage.translatesAutoresizingMaskIntoConstraints = false
        fullImage.center(vertically: true, horizontally: true)
        fullImage.stretchSafe()
        fullImage.contentMode = .scaleAspectFit
        fullImage.backgroundColor = .blue.withAlphaComponent(0.3)
    }
    
}
