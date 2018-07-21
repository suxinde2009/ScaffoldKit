//
//  DispatchQueue+AsyncAfter.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import Dispatch

public extension DispatchQueue {
    public func asyncAfter(delay: Double, execute block: @escaping () -> Void) {
        self.asyncAfter(deadline: .now() + delay, execute: block)
    }
}
