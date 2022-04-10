//
//  SettingsView.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class SettingsView: UIView {
    //MARK: - data
    
    let userIconImageView = UIImageView()
    let userNicknameLabel = UILabel()
    let headerView = UIView()
    let tableView = UITableView()
    let logoutButton = UIButton()
    
    //MARK: - public functions
    
    init() {
        super.init(frame: .zero)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private functions
    
    private func prepare() {
        self.backgroundColor = .systemGroupedBackground
        setupUserIconImageView()
        setupUserNickNameLabel()
        setupTableView()
        setupLogoutButton()
    }
    
    private func setupUserIconImageView() {
        self.addSubview(userIconImageView)
        userIconImageView.translatesAutoresizingMaskIntoConstraints = false
        userIconImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        userIconImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        userIconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        userIconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        userIconImageView.layer.cornerRadius = 50
        userIconImageView.image = UIImage(named: "dogTemplate")
        userIconImageView.contentMode = .scaleAspectFit
        userIconImageView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        userIconImageView.layer.masksToBounds = true
    }
    
    private func setupUserNickNameLabel() {
        self.addSubview(userNicknameLabel)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNicknameLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        userNicknameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        userNicknameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userNicknameLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        userNicknameLabel.textAlignment = .center
        userNicknameLabel.text = "USER_NICKNAME"
        userNicknameLabel.font = UIConst.nicknameFont
    }
    
    private func setupTableView() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 10).isActive = true
        tableView.topAnchor.constraint(equalTo: userIconImageView.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupLogoutButton() {
        self.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.backgroundColor = UIColor(
            red: 162 / 255,
            green: 77 / 255,
            blue: 74 / 255,
            alpha: 1)
        logoutButton.layer.cornerRadius = 20
    }
    
}
