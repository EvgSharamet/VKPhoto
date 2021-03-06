//
//  UserService.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 09.04.2022.
//

import Foundation
import UIKit



import Foundation
import UIKit

class UserService: IUserService {
    //MARK: - types
    
    private struct UserData: Codable {
        var userList = [User]()
        var activeUserIndex: Int?
    }
    
    //MARK: - data
    
    var userChangedListener: (() -> Void)?
    private let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(storeFileName)
   
    private var data = UserData()
    private static let storeFileName = "catalog.data"
    
    //MARK: - public functions
    
    func getUsers() -> [User] {
        return data.userList
    }
    
    func addUser(_ user: User) -> Int {
        data.userList.append(user)
        return data.userList.indices.last ?? 0
    }
    
    func removeUser(index: Int) {
        data.userList.remove(at: index)
    }
    
    func updateUser(_ user: User, index: Int) {
        data.userList[index] = user
    }
    
    func getActiveUserIndex() -> Int? {
        return data.activeUserIndex
    }
    
    func setActiveUserIndex(index: Int?) {
        data.activeUserIndex = index
    }
    
    func save() {
        do {
            guard let url = url else { return }
            let dataForJson = self.data
            let encoder = JSONEncoder()
            let data = try encoder.encode(dataForJson)
            try data.write(to: url, options: [])
            userChangedListener?()
        } catch { }
    }
    
    func load() {
        do {
            guard let url = url else { return }
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let container = try decoder.decode(UserData.self, from: jsonData)
            self.data = container
        } catch { }
    }
    
    func findUser(login: String, password: String) -> Int? {
        return data.userList
                .enumerated()
                .first { $0.element.login == login && $0.element.password == password }?
                .offset
    }
}
