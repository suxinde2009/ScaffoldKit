//
//  TableViewDataSource.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class TableViewDataSource: NSObject {
    var sections: [TableViewSection] = []
    func register(tableView: UITableView) {
        for section in self.sections {
            for item in section.items {
                tableView.register(item.cell, forCellReuseIdentifier: String(describing: item.cell))
            }
        }
    }
}

extension TableViewDataSource: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = self.sections[indexPath.section]
        let item = section.items[indexPath.row]
        let id = String(describing: item.cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        item.config(cell: cell, data: item.value, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = self.sections[indexPath.section]
        let item = section.items[indexPath.row]
        return item.height(data: item.value, indexPath: indexPath)
    }
}

extension TableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = self.sections[indexPath.section]
        let item = section.items[indexPath.row]
        item.callback(data: item.value, indexPath: indexPath)
    }
}
