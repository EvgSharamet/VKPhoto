//
//  SettingsController.swift
//  VKPhoto
//
//  Created by Евгения Шарамет on 04.04.2022.
//

import Foundation
import UIKit

class SettingsController: UIViewController {

    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = SettingsView()
        self.view = view
        view.prepare()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
}

extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  //      let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
  //      cell.textLabel?.text = self.data[indexPath.row]
   //     if indexPath.row == 0 {
    //       cell.accessoryType = .disclosureIndicator
    //    } else {
      //     cell.accessoryType = .none
     //   }
        return UITableViewCell()
     }
}

class TableViewCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
