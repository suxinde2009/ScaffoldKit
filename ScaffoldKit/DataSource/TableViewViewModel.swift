//
//  TableViewViewModelProtocol.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

public protocol TableViewViewModelProtocol {
    var cell: UITableViewCell.Type { get }
    var value: Any { get }
    
    func config(cell: UITableViewCell, data: Any, indexPath: IndexPath)
    func height(data: Any, indexPath: IndexPath) -> CGFloat
    func callback(data: Any, indexPath: IndexPath)
}

open class TableViewViewModel<Cell, Data>: TableViewViewModelProtocol where Cell: UITableViewCell, Data: Any {
    
    public var data: Data
    public var cell: UITableViewCell.Type { return Cell.self }
    public var value: Any { return self.data }
    
    public init(data: Data) {
        self.data = data
    }
    
    // MARK: - TableViewViewModelProtocol
    
    public func config(cell: UITableViewCell, data: Any, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let data = data as? Data else {
            return
        }
        self.config(cell: cell, data: data, indexPath: indexPath)
    }
    
    public func height(data: Any, indexPath: IndexPath) -> CGFloat {
        guard let data = data as? Data else {
            return 44
        }
        return self.height(data: data, indexPath: indexPath)
    }
    
    public func callback(data: Any, indexPath: IndexPath) {
        guard let data = data as? Data else {
            return
        }
        self.callback(data: data, indexPath: indexPath)
    }
    
    // MARK: - API
    
    open func config(cell: Cell, data: Data, indexPath: IndexPath) {
        
    }
    
    open func height(data: Data, indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    open func callback(data: Data, indexPath: IndexPath) {
        
    }
}
