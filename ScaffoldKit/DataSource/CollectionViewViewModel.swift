//
//  CollectionViewViewModel.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

public protocol CollectionViewViewModelProtocol {
    
    var cell: UICollectionViewCell.Type { get }
    var value: Any { get }
    
    func config(cell: UICollectionViewCell, data: Any, indexPath: NSIndexPath, grid: Grid)
    func size(data: Any, indexPath: NSIndexPath, grid: Grid, view: UIView) -> CGSize
    func callback(data: Any, indexPath: NSIndexPath)
}

open class CollectionViewViewModel<Cell, Data>: CollectionViewViewModelProtocol where Cell: UICollectionViewCell, Data: Any {
    
    public var data: Data
    public var cell: UICollectionViewCell.Type { return Cell.self }
    public var value: Any { return self.data }
    
    public init(_ data: Data) {
        self.data = data
        self.initialize()
    }
    
    // MARK: - CollectionViewViewModelProtocol
    
    public func config(cell: UICollectionViewCell, data: Any, indexPath: NSIndexPath, grid: Grid) {
        guard let data = data as? Data, let cell = cell as? Cell else {
            return
        }
        return self.config(cell: cell, data: data, indexPath: indexPath, grid: grid)
    }
    
    public func size(data: Any, indexPath: NSIndexPath, grid: Grid, view: UIView) -> CGSize {
        guard let data = data as? Data else {
            return .zero
        }
        return self.size(data: data, indexPath: indexPath, grid: grid, view: view)
    }
    
    public func callback(data: Any, indexPath: NSIndexPath) {
        guard let data = data as? Data else {
            return
        }
        return self.callback(data: data, indexPath: indexPath)
    }
    
    // MARK: - API
    
    open func initialize() {
        
    }
    
    open func config(cell: Cell, data: Data, indexPath: NSIndexPath, grid: Grid) {
        
    }
    
    open func size(data: Data, indexPath: NSIndexPath, grid: Grid, view: UIView) -> CGSize {
        return .zero
    }
    
    open func callback(data: Data, indexPath: NSIndexPath) {
        
    }
}
