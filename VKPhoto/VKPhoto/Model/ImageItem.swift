//
//  ImageItem.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 05.04.2022.
//

import Foundation
import UIKit

struct ImageItem: Codable {
    let filename: String
    var filter: String?
}

struct ImageItemRepo: Codable {
    var items: [ImageItem]
}

extension ImageItem {
    //MARK: - internal functions
    
    func getImage() -> UIImage? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filename) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
}

