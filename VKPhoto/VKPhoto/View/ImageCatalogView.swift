//
//  ImageCatalogView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class ImageCatalogView: UIView {
    //MARK: - data
    
    let userIconImageView = UIImageView()
    let userIconImageButton = UIButton()
    let userNicknameLabel = UILabel()
    let settingsButton = UIButton()
    let imageCollection: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    let plusButton = UIButton()
    
    //MARK: - internal functions
    
    func prepare() {
        self.backgroundColor = .white
        setupUserNickNameLabel()
        setupUserIconImageView()
        setupUserIconImageButton()
        setupIconImageView()
        setupSettingsButton()
        setupImageCollection()
        setupPlusButton()
      }
    
    //MARK: - private functions
    
    private func setupUserNickNameLabel() {
        self.addSubview(userNicknameLabel)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNicknameLabel.center(vertically: false, horizontally: true)
        userNicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        userNicknameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userNicknameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        userNicknameLabel.textAlignment = .center
        userNicknameLabel.font = UIConst.nicknameFont
        userNicknameLabel.text = "USER_NICKNAME"
    }
    
    private func setupUserIconImageView() {
        self.addSubview(userIconImageView)
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userIconImageView.center(vertically: false, horizontally: true)
        userIconImageView.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 15).isActive = true
        userIconImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        userIconImageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
        userIconImageView.layer.cornerRadius = 90
        userIconImageView.layer.masksToBounds = true
    }
    
    private func  setupUserIconImageButton() {
        self.addSubview(userIconImageButton)
        userIconImageButton.translatesAutoresizingMaskIntoConstraints = false
        userIconImageButton.widthAnchor.constraint(equalTo: userIconImageView.widthAnchor).isActive = true
        userIconImageButton.centerXAnchor.constraint(equalTo: userIconImageView.centerXAnchor).isActive = true
        userIconImageButton.centerYAnchor.constraint(equalTo: userIconImageView.centerYAnchor).isActive = true
        userIconImageButton.heightAnchor.constraint(equalTo: userIconImageView.heightAnchor).isActive = true
        userIconImageButton.layer.cornerRadius = userIconImageView.layer.cornerRadius
    }
    
    private func setupIconImageView() {
        userIconImageView.image = UIImage(named: "dogTemplate")
        userIconImageView.contentMode = .scaleAspectFit
        userIconImageView.backgroundColor = .systemGray6
    }
    
    private func setupSettingsButton() {
        self.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -15).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        settingsButton.setImage(UIImage(named: "settingsIcon"), for: .normal)
    }
    
    private func setupImageCollection() {
        self.addSubview(imageCollection)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 20).isActive = true
        imageCollection.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        imageCollection.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        imageCollection.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupPlusButton() {
        self.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.center(vertically: false, horizontally: true)
        plusButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        plusButton.setImage(UIImage(named: "plusButtonIcon"), for: .normal)
        plusButton.layer.cornerRadius = 40
    }
}
