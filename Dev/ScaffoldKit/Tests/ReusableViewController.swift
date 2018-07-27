//
//  ReusableViewController.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/28.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import UIKit

class ReusableViewController: UIViewController, Reusable {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("\(self)")
    }
    
    internal func prepareForReuse() {
        self.view.backgroundColor = randomColor()
    }
    
    private static func newForReuse() -> Any? {
        return ReusableViewController()
    }
    
    func randomColor() -> UIColor {
        let hue = CGFloat( Double(arc4random() % 256) / 256.0 );
        let saturation = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;
        let brightness = CGFloat( Double(arc4random() % 128) / 256.0 ) + 0.5;
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    override func didMove(toParentViewController parent: UIViewController?) {
//        if parent == nil {
            ReusableQueue.shared.enqueueReusable(self)
//        }
    }
}
