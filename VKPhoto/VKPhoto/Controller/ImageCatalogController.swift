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
    var settingsButtonDidTapDelegate: (() ->  Void)?
    var imageStack: UIStackView?
    var getImageDelegate: ((ImageItem?) -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ImageCatalogView()
        
     //   self.view = view
      //  view.prepare()
      //  self.userIconImageView = view.userIconImageView
     //   self.userNicknameLabel = view.userNicknameLabel
     //   self.settingsButton = view.settingsButton
        
        settingsButton?.addTarget(self, action: #selector(settingsButtonDidTap), for: .touchUpInside)
        
     //   let imagePicker = UIImagePickerController()
    //    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
      //  imagePicker.delegate = self
      //  self.present(imagePicker, animated: true, completion: nil)
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
