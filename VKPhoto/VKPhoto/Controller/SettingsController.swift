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
    private let userService: IUserService
    
    //MARK: - public functions
    
    init(userService: IUserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - internal functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SettingsView()
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.stretch()
        
        self.tableView = view.tableView
        tableView?.delegate = self
        tableView?.dataSource = self
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        guard let activeUserIndex = userService.getActiveUserIndex() else { return }
        let activeUser = (userService.getUsers())[activeUserIndex]
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
            self.userService.setActiveUserIndex(index: nil)
            self.userService.save()
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
        userService.getUsers().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: SettingsController.identifier, for: indexPath) as! TableViewCell
        let user = (userService.getUsers())[indexPath.row]
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
