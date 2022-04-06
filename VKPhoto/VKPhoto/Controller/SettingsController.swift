//
//  SettingsController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class SettingsController: UIViewController {

    var userIconImageView: UIImageView?
    var userNicknameLabel: UILabel?
    var tableView: UITableView?
    var logoutButton: UIButton?
    public var logoutButtonDidTapDelegate : (() ->  Void)?
    
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
        let activeUser = UserService.shared.userList[activeUserIndex]
        if let userAvatar = activeUser.avatar?.getImage() {
            userIconImageView?.image = userAvatar
        }
        userNicknameLabel?.text = activeUser.login
        
        self.logoutButton?.addTarget(self, action: #selector(logoutButtonDidTap), for: .touchUpInside)
    }
    
    @objc func logoutButtonDidTap() {
        let logoutAlert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        let submitAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.logoutButtonDidTapDelegate?()
        }
        logoutAlert.addAction(submitAction)
        logoutAlert.addAction(cancelAction)
        present(logoutAlert, animated: true)
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserService.shared.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.prepare()
        let user = UserService.shared.userList[indexPath.row]
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

class TableViewCell: UITableViewCell {
    let userIconImageView = UIImageView()
    let userNicknameLabel = UILabel()
    
    func prepare() {
        self.selectionStyle = .none
        self.contentView.addSubview(userIconImageView)
        self.contentView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        guard let superview = userIconImageView.superview else { return }
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userIconImageView.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 5).isActive = true
        userIconImageView.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        userIconImageView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 3).isActive = true
        userIconImageView.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -3).isActive = true
        userIconImageView.widthAnchor.constraint(equalTo: userIconImageView.heightAnchor).isActive = true
        userIconImageView.layer.cornerRadius = 37
        userIconImageView.backgroundColor = .blue.withAlphaComponent(0.5)
        userIconImageView.contentMode = .scaleAspectFit
        userIconImageView.layer.masksToBounds = true
        userIconImageView.image = UIImage(named: "dogTemplate")
        
        self.contentView.addSubview(userNicknameLabel)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNicknameLabel.leftAnchor.constraint(equalTo: userIconImageView.rightAnchor, constant: 5).isActive = true
        userNicknameLabel.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 5).isActive = true
        userNicknameLabel.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        userNicknameLabel.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
        userNicknameLabel.textAlignment = .center
        userNicknameLabel.text = "USER_NICKNAME"
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
