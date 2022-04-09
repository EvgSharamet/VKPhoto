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
    
    private var tableView: UITableView?
    private static let identifier = "TableViewCell"
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SettingsView()
        self.view = view
        
        self.tableView = view.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        guard let activeUserIndex = UserService.shared.getActiveUserIndex() else { return }
        let activeUser = (UserService.shared.getUsers())[activeUserIndex]
        if let userAvatar = activeUser.avatar?.getImage() {
            view.userIconImageView.image = userAvatar
        }
        view.userNicknameLabel.text = activeUser.login
        
        view.logoutButton.addTarget(self, action: #selector(logoutButtonDidTap), for: .touchUpInside)
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
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: SettingsController.identifier, for: indexPath) as! TableViewCell
        let user = (UserService.shared.getUsers())[indexPath.row]
        let userAvatar = user.avatar?.getImage()
        
        cell.configure(cellData: TableViewCell.CellData(
                                        username: user.login,
                                        avatar: userAvatar))
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
