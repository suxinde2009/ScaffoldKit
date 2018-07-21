//
//  CGFloat+EvenRounded.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/22.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
    public var evenRounded: CGFloat {
        var newValue = self.rounded(.towardZero)
        if newValue.truncatingRemainder(dividingBy: 2) == 1 {
            newValue -= 1
        }
        return newValue
    }
}
