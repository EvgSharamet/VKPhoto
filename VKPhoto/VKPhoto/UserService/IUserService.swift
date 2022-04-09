//
//  IUserService.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 09.04.2022.
//

struct User: Codable {
    let login: String
    let password: String
    var avatar: ImageItem?
    var imageСollection: [ImageItem]
}

protocol IUserService: AnyObject {
    var userChangedListener: (() -> Void)? { get set }
    
    func getUsers() -> [User]
    func addUser(_ user: User) -> Int
    func removeUser(index: Int)
    func updateUser(_ user: User, index: Int)
    func getActiveUserIndex() -> Int?
    func setActiveUserIndex(index: Int?)
    func save()
    func load()
    func findUser(login: String, password: String) -> Int?
}
