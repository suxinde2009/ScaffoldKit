//
//  AnimationSequence.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import UIKit

/// 动画序列类，用于配置连续执行的一个系列的动画效果
public class AnimationSequence {
    
    /// 单个动画实体
    public struct AnimationItem {
        /// 动画时长
        public let duration: TimeInterval
        /// 切换效果
        public let curve: UIViewAnimationCurve
        /// 动画内容
        public let animation: VoidBlock
        /// 完成回调
        public let completion: VoidBlock?
        
        /// 初始化方法
        ///
        /// - Parameters:
        ///   - duration: 时长
        ///   - animation: 动画内容
        ///   - curve: 切换效果
        ///   - completion: 完成回调
        public init(duration: TimeInterval,
                    animation: @escaping VoidBlock,
                    curve: UIViewAnimationCurve,
                    completion: VoidBlock? = nil) {
            self.duration = duration
            self.animation = animation
            self.curve = curve
            self.completion = completion
        }
    }
    
    /// 时长
    public let duration: TimeInterval
    /// 延时
    public let delay: TimeInterval
    /// 完成回调
    public let completion: VoidBlock?
    
    /// 动画是否在执行中
    public private(set) var isRunning: Bool = false
    
    
    private var sequence: [AnimationItem] = []
    private var isFirst: Bool = true
    
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - duration: 时长
    ///   - delay: 延时
    ///   - completion: 完成回调
    public init(duration: TimeInterval,
                delay: TimeInterval = 0,
                completion: VoidBlock?) {
        self.duration = duration
        self.delay = delay
        self.completion = completion
    }
    
    /// 添加动画
    ///
    /// - Parameter animation: 要添加的动画
    public func add(_ animation: AnimationItem) {
        self.sequence.append(animation)
    }
    
    /// 开始执行动画组
    public func start() {
        isRunning = true
        performNextAnimation()
    }
    
    /// 执行动画组内的下一个可执行动画
    private func performNextAnimation() {
        guard self.sequence.isEmpty == false else {
            isRunning = false
            completion?()
            return
        }
        let item = sequence.removeFirst()
        let duration = item.duration * self.duration
        let options = UIViewAnimationOptions(rawValue: UInt(item.curve.rawValue << 16))
        let delay: TimeInterval = self.isFirst ? self.delay : 0
        
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: options,
                       animations: item.animation) {[weak self] _ in
                        item.completion?()
                        self?.isFirst = false
                        self?.performNextAnimation()
        }
    }
}
