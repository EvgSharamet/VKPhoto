//
//  ImageCatalogController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class ImageCatalogController: UIViewController {
    
    var userIconImageView: UIImageView?
    var userIconImageButton: UIButton?
    var userNicknameLabel: UILabel?
    var settingsButton: UIButton?
    var imageCollection: UICollectionView?
    var plusButton: UIButton?
    let imagePicker = UIImagePickerController()
    static let identifier = "CollectionViewCell"
    var isEditingAvatar = true
    
    var settingsButtonDidTapDelegate: (() ->  Void)?
    var getImageDelegate: ((ImageItem?) -> Void)?
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 10.0
        static let itemHeight: CGFloat = 150.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageCatalogView()
        self.view = view
        view.prepare()
        
        self.userIconImageView = view.userIconImageView
        self.userIconImageButton = view.userIconImageButton
        self.userNicknameLabel = view.userNicknameLabel
        self.settingsButton = view.settingsButton
        self.imageCollection = view.imageCollection
        self.plusButton = view.plusButton
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(CollectionCell.self, forCellWithReuseIdentifier: ImageCatalogController.identifier)
        
        settingsButton?.addTarget(self, action: #selector(settingsButtonDidTap), for: .touchUpInside)
        plusButton?.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
        userIconImageButton?.addTarget(self, action: #selector(userIconImageButtonDidTap), for: .touchUpInside)
        
        //ОЧЕНЬ БОЛЬШАЯ ЗАГЛУШКА :
        let fakeUser = UserService.User(login: "fakeLogin", password: "fakePassword", avatar: nil, imageСollection: [])
        UserService.shared.addUser(fakeUser)
        UserService.shared.setActiveUserIndex(index: 0)
        
        
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
        let activeUser = UserService.shared.userList[activeUserIndex]
        if let userAvatar = activeUser.avatar?.getImage() {
            userIconImageView?.image = userAvatar
        }
        userNicknameLabel?.text = activeUser.login
    }

    @objc func settingsButtonDidTap() {
        settingsButtonDidTapDelegate?()
    }
    
    @objc func plusButtonDidTap() {
        isEditingAvatar = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func userIconImageButtonDidTap() {
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
                let activeUser = UserService.shared.userList[activeUserIndex]
                var activeUserWithUpdate = activeUser
                activeUserWithUpdate.avatar = newAvatar
                UserService.shared.updateUser(activeUserWithUpdate, index: activeUserIndex)
                self.userIconImageView?.image = newAvatar.getImage()
            } else {
                let newItem = ImageItem(filename: imageName)
                guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
                var user = UserService.shared.userList[activeUserIndex]
                user.imageСollection.append(newItem)
                UserService.shared.updateUser(user, index: activeUserIndex)
                imageCollection?.reloadData()
            }
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

extension ImageCatalogController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else {  return 0 } // тут нужна заглушка на такое дело
        return UserService.shared.userList[activeUserIndex].imageСollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCatalogController.identifier, for: indexPath) as! CollectionCell
        cell.prepare()
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return cell }
        let activeUser = UserService.shared.userList[activeUserIndex]
        cell.imageView.image = activeUser.imageСollection[indexPath.row].getImage()
        return cell
    }
    
}

extension ImageCatalogController: UICollectionViewDelegate { }

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension ImageCatalogController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
            let itemsInRow: CGFloat = 2

            let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
            let finalWidth = (width - totalSpacing) / itemsInRow

            return floor(finalWidth)
        }
}

class CollectionCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    func prepare() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.stretch()
        imageView.contentMode = .scaleAspectFit
    }
}

