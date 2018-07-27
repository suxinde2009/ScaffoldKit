//
//  ResualbeQueue.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/28.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import UIKit

/// 可复用对象实例抽象 
@objc public protocol Reusable : class {
    /// 如果未实现该协议，默认返回类名
    @objc optional static func reuseIdentifier() -> String
    
    /// 如果实现该方法，则dequeueOrCreateReusableWithClass可用
    @objc optional static func newForReuse() -> AnyObject?
    
    /// 复用实例方法
    @objc optional func prepareForReuse() -> Void
    
}

/// 对象实例复用队列
@objc public class ReusableQueue: NSObject {
    
    // MARK: - *** Public vars *** -
    /// 收到内存警告时是否清空缓存
    public var emptyOnMemoryWarningNotification: Bool = true
    
    /// 单例
    public static let shared = ReusableQueue()
    
    
    // MARK: - *** Private vars *** -
    private var resuables = NSCache<AnyObject, AnyObject>()
    
    // MARK: - *** Public API *** -
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public init() {
        super.init()
        self.addObservers()
    }
    
    public func emptyQueue() {
        resuables.removeAllObjects()
    }
    
    public func enqueueReusable(_ reusable: Reusable) {
        let identifier = identifierFromReusableClass(type(of: reusable))
        var objects: [Reusable] = resuables.object(forKey: identifier as AnyObject) as? [Reusable] ?? Array<Reusable>()
        reusable.prepareForReuse?()
        objects.append(reusable)
        resuables.setObject(objects as AnyObject, forKey: identifier as AnyObject)
    }
    
    public func dequeueReusableWithIdentifier(_ identifier: String) -> Reusable? {
        guard var objects: [Reusable] = resuables.object(forKey: identifier as AnyObject) as? [Reusable]else {
            return nil
        }
        guard objects.count > 0 else {
            return nil
        }
        let reusable = objects.removeFirst()
        resuables.setObject(objects as AnyObject, forKey: identifier as AnyObject)
        return reusable
    }
    
    public func dequeueReusableWithClass(_ reusableClass: Reusable.Type) -> Reusable? {
        let identifier = identifierFromReusableClass(reusableClass)
        return dequeueReusableWithIdentifier(identifier)
    }
    
    public func dequeueOrCreateReusableWithClass(_ reusableClass: Reusable.Type) -> Reusable? {
        if let reusable = dequeueReusableWithClass(reusableClass) {
            return reusable
        }
        guard let resuable = reusableClass.newForReuse?() as? Reusable else {
            return nil
        }
        return resuable
    }
    
    
    // MARK: - *** Private API *** -
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveMemoryWarning),
                                               name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning,
                                               object: nil)
    }
    
    @objc private func didReceiveMemoryWarning() {
        if !emptyOnMemoryWarningNotification {
            return
        }
        emptyQueue()
    }
    
    private func identifierFromReusableClass(_ resuable: Reusable.Type) -> String {
        if let identifier = resuable.reuseIdentifier?() {
            return identifier
        }
        return  NSStringFromClass(resuable)
    }
    
}
