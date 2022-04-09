//
//  ImageCatalogController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class ImageCatalogController: UIViewController {
    //MARK: - types
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 10.0
        static let itemHeight: CGFloat = 150.0
    }
    
    //MARK: - data
    
    var settingsButtonDidTapDelegate: (() ->  Void)?
    
    private var userIconImageView: UIImageView?
    private var userNicknameLabel: UILabel?
    private var imageCollection: UICollectionView?
    private var isEditingAvatar = true
    private static let identifier = "CollectionViewCell"
    private let imagePicker = UIImagePickerController()
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageCatalogView()
        self.view = view
        view.prepare()
        
        self.userIconImageView = view.userIconImageView
        self.userNicknameLabel = view.userNicknameLabel
        self.imageCollection = view.imageCollection
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(CollectionCell.self, forCellWithReuseIdentifier: ImageCatalogController.identifier)
        
        view.settingsButton.addTarget(self, action: #selector(settingsButtonDidTap), for: .touchUpInside)
        view.plusButton.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
        view.userIconImageButton.addTarget(self, action: #selector(userIconImageButtonDidTap), for: .touchUpInside)
        
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
        let activeUser = (UserService.shared.getUsers())[activeUserIndex]
        if let userAvatar = activeUser.avatar?.getImage() {
            userIconImageView?.image = userAvatar
        }
        userNicknameLabel?.text = activeUser.login
        
        UserService.shared.userChangedListener = { self.viewDidLoad()}
    }

    //MARK: - internal functions
    
    @objc private func settingsButtonDidTap() {
        settingsButtonDidTapDelegate?()
    }
    
    @objc private func plusButtonDidTap() {
        isEditingAvatar = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func userIconImageButtonDidTap() {
        isEditingAvatar = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ImageCatalogController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: - internal functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        
        do {
            let imagePath = try getDocumentsDirectory().appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: imagePath)
            }
            if isEditingAvatar {
                let newAvatar = ImageItem(filename: imageName)
                guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
                let activeUser = (UserService.shared.getUsers())[activeUserIndex]
                var activeUserWithUpdate = activeUser
                activeUserWithUpdate.avatar = newAvatar
                UserService.shared.updateUser(activeUserWithUpdate, index: activeUserIndex)
                self.userIconImageView?.image = newAvatar.getImage()
            } else {
                let newItem = ImageItem(filename: imageName)
                guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
                var user = (UserService.shared.getUsers())[activeUserIndex]
                user.imageСollection.append(newItem)
                UserService.shared.updateUser(user, index: activeUserIndex)
                imageCollection?.reloadData()
            }
            UserService.shared.save()
        } catch {
            print("ImageCatalogControllerError: \(error)")
        }
        dismiss(animated: true)
    }
    
    //MARK: - private functions
    
    private func getDocumentsDirectory() throws -> URL {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NSError()
        }
        return dir
    }
}

extension ImageCatalogController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else {  return 0 } // тут нужна заглушка на такое дело
        return (UserService.shared.getUsers())[activeUserIndex].imageСollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCatalogController.identifier, for: indexPath) as! CollectionCell
        cell.prepare()
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return cell }
        let activeUser = (UserService.shared.getUsers())[activeUserIndex]
        cell.imageView.image = activeUser.imageСollection[indexPath.row].getImage()
        return cell
    }
}

extension ImageCatalogController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        let height = width
        return CGSize(width: width, height: height )
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2

        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow

        return floor(finalWidth)
    }
}
