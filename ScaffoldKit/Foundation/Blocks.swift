//
//  Blocks.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation

/**
 通用的空参数回调block
 */
public typealias VoidBlock = () -> Void

/**
 泛型参数回调block
 */
public typealias ValueBlock<T> = (T) -> Void

/**
 错误参数回调block
 */
public typealias ErrorBlock = (Error) -> Void

/// 带泛型参数及错误类型的结果回调block
public typealias ResultBlock<T> = (T, Error) -> Void
