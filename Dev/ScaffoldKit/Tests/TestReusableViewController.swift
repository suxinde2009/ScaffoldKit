//
//  TestReusableViewController.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2018/7/28.
//  Copyright © 2018年 su xinde. All rights reserved.
//

import UIKit

class TestReusableViewController: UIViewController, UIPageViewControllerDataSource {

    let pageVC = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.orange
        pageVC.dataSource = self
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstViewController = ReusableViewController()
        pageVC.setViewControllers([firstViewController],
                                  direction: .forward,
                                  animated: false,
                                  completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = ReusableQueue.shared.dequeueOrCreateReusableWithClass(ReusableViewController.self) as? ReusableViewController {
            return viewController
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = ReusableQueue.shared.dequeueOrCreateReusableWithClass(ReusableViewController.self) as? ReusableViewController {
            return viewController
        }
        return nil
    }
    
}
