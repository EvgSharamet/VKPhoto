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
    var userNicknameLabel: UILabel?
    var settingsButton: UIButton?
    var imageCollection: UICollectionView?
    var plusButton: UIButton?
    
    var settingsButtonDidTapDelegate: (() ->  Void)?
    var getImageDelegate: ((ImageItem?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageCatalogView()
        self.view = view
        view.prepare()
        self.userIconImageView = view.userIconImageView
        self.userNicknameLabel = view.userNicknameLabel
        self.settingsButton = view.settingsButton
        self.imageCollection = view.imageCollection
        self.plusButton = view.plusButton
        
        imageCollection?.dataSource = self
        imageCollection?.delegate = self
        imageCollection?.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        
        settingsButton?.addTarget(self, action: #selector(settingsButtonDidTap), for: .touchUpInside)
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }

    @objc func settingsButtonDidTap() {
        settingsButtonDidTapDelegate?()
    }
}

extension ImageCatalogController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - internal functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        
        do {
            let imagePath = try getDocumentsDirectory().appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: imagePath)
            }

            let newItem = ImageItem(filename: imageName)
            CatalogDataService.shared.appendItem(newItem)
            CatalogDataService.shared.save()
            imageCollection?.reloadData()
            getImageDelegate?(newItem)
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
        return CatalogDataService.shared.data.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as! CollectionCell
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView.image = UIImage(named: "dogTemplate")
        cell.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cell.widthAnchor.constraint(equalToConstant: 300).isActive = true
        cell.prepare()
        return cell
    }
    
}

extension ImageCatalogController: UICollectionViewDelegate { }

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class CollectionCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    func prepare() {
        self.contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.stretch()
        imageView.backgroundColor = .green.withAlphaComponent(0.3)
        imageView.contentMode = .scaleAspectFit
    }
}

extension CollectionCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
