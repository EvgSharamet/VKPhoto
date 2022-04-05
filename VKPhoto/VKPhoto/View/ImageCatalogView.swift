//
//  ImageCatalogView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class ImageCatalogView: UIView {
    
    let userIconImageView = UIImageView()
    let userNicknameLabel = UILabel()
    let settingsButton = UIButton()
    let imageCollection = UICollectionView()
    
    func prepare() {
        self.backgroundColor = .white
        
        self.addSubview(userNicknameLabel)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNicknameLabel.center(vertically: false, horizontally: true)
        userNicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        userNicknameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userNicknameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userNicknameLabel.textAlignment = .center
        userNicknameLabel.font = UIConst.nicknameFont
        userNicknameLabel.text = "USER_NICKNAME"
        
        self.addSubview(userIconImageView)
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userIconImageView.center(vertically: false, horizontally: true)
        userIconImageView.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 15).isActive = true
        userIconImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        userIconImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        userIconImageView.layer.cornerRadius = 90
        
        userIconImageView.image = UIImage(named: "dogTemplate")
        userIconImageView.contentMode = .scaleAspectFit
        userIconImageView.backgroundColor = .systemGray6

        self.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
    
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
        
        //self.addSubview(imageCollection)
   //     imageCollection.translatesAutoresizingMaskIntoConstraints = false
    //    imageCollection.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 20).isActive = true
      //  imageCollection.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
      //  imageCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
   
        
      }
}
