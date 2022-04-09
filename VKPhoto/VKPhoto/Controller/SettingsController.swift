//
//  SettingsController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class SettingsController: UIViewController {
    //MARK: - data
    
    var logoutButtonDidTapDelegate : (() ->  Void)?
    
    private var userIconImageView: UIImageView?
    private var userNicknameLabel: UILabel?
    private var tableView: UITableView?
    private var logoutButton: UIButton?
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SettingsView()
        self.view = view
        view.prepare()
        
        self.userIconImageView = view.userIconImageView
        self.userNicknameLabel = view.userNicknameLabel
        self.tableView = view.tableView
        self.logoutButton = view.logoutButton
        
        tableView?.delegate = self
        tableView?.dataSource = self
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
        let activeUser = (UserService.shared.getUsers())[activeUserIndex]
        if let userAvatar = activeUser.avatar?.getImage() {
            userIconImageView?.image = userAvatar
        }
        userNicknameLabel?.text = activeUser.login
        
        self.logoutButton?.addTarget(self, action: #selector(logoutButtonDidTap), for: .touchUpInside)
    }
    
    //MARK: - private functions
    
    @objc private func logoutButtonDidTap() {
        let logoutAlert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
            UserService.shared.setActiveUserIndex(index: nil)
            UserService.shared.save()
            self.logoutButtonDidTapDelegate?()
        }
        logoutAlert.addAction(submitAction)
        logoutAlert.addAction(cancelAction)
        present(logoutAlert, animated: true)
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - internal functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserService.shared.getUsers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.prepare()
        let user = (UserService.shared.getUsers())[indexPath.row]
        if let userAvatar = user.avatar?.getImage() {
            cell.userIconImageView.image = userAvatar
        }
        cell.userNicknameLabel.text = user.login
        return cell
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .white
        headerLabel.text = "Other users:"
        headerLabel.font = UIConst.tableHeaderFont
        headerLabel.textColor = .darkGray
        return headerLabel
    }
}
