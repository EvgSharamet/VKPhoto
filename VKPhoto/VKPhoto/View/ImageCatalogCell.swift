//
//  CollectionCell.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 09.04.2022.
//

import Foundation
import UIKit

class ImageCatalogCell: UICollectionViewCell {
    //MARK: - data
    
    let imageView = UIImageView()
    
    //MARK: - public functions
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?){
        imageView.image = image
    }
    
    //MARK: - private functions
    
     private func prepare() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.stretch()
    }
}
