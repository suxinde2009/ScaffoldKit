//
//  View.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

/**
 使用模板方法模式指定视图的初始化重载点
 */

/// 基础视图类
open class View: UIView {
    /// 重载构造方法
    public init() {
        super.init(frame: .zero)
        self.initialize()
    }
    
    /// 重载构造方法
    ///
    /// - Parameter frame: 指定给view的frame
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    /// 构造方法
    ///
    /// - Parameter aDecoder: 实例对象使用的coder
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    /// 初始化重载点
    open func initialize() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
