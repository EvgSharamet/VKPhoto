//
//  CollectionCell.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 09.04.2022.
//

import Foundation
import UIKit

class CollectionCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    func prepare() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.stretch()
        imageView.contentMode = .scaleAspectFit
    }
}
