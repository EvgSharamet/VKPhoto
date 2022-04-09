//
//  TableViewCell.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 09.04.2022.
//

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    //MARK: - types
    struct CellData{
        let username: String
        let avatar: UIImage?
    }
    
    //MARK: - data
    
    let userIconImageView = UIImageView()
    let userNicknameLabel = UILabel()
    
    //MARK: - public functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellData: CellData){
        userNicknameLabel.text = cellData.username
        if cellData.avatar == nil {
            userIconImageView.image = UIImage(named: "dogTemplate")
        } else {
            userIconImageView.image = cellData.avatar
        }
    }
    
    //MARK: - private functions
    
    private func prepare() {
        self.selectionStyle = .none
        setupUserIconImageView()
        setupUserNicknameLabel()
    }
    
    private func setupUserIconImageView() {
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
        userIconImageView.backgroundColor = .lightGray
        userIconImageView.contentMode = .scaleAspectFit
        userIconImageView.layer.masksToBounds = true
    }
    
    private func setupUserNicknameLabel() {
        self.contentView.addSubview(userNicknameLabel)
        guard let superview = userNicknameLabel.superview else { return }
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNicknameLabel.leftAnchor.constraint(equalTo: userIconImageView.rightAnchor, constant: 5).isActive = true
        userNicknameLabel.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 5).isActive = true
        userNicknameLabel.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        userNicknameLabel.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
        userNicknameLabel.textAlignment = .center
    }
}
