//
//  UserService.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 05.04.2022.
//

import Foundation
import UIKit

class UserService {
    struct User: Codable {
        let login: String
        let password: String
        var avatar: ImageItem?
        var imageСollection: [ImageItem]
    }
    
    static let shared = UserService()
    
    private var activeUserIndex: Int?
    private(set) var userList : [User] = []
    
    func getUsers() -> [User] {
        return userList
    }
    
    func addUser(_ user: User) {
        userList.append(user)
    }
    
    func removeUser(index: Int) {
        userList.remove(at: index)
    }
    
    func updateUser(_ user: User, index: Int) {
        userList[index] = user
    }
    
    func getActiveUserIndex() -> Int? {
        return activeUserIndex
    }
    
    func setActiveUserIndex(index: Int) {
        activeUserIndex = index
    }
    
    private init() {}
}
