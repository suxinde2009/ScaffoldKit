//
//  MainThreadLagDetector.swift
//  ScaffoldKit
//
//  Created by SuXinDe on 2019/3/7.
//  Copyright © 2019 su xinde. All rights reserved.
//

import UIKit

class MainThreadLagDetector: NSObject {
    fileprivate let pingThread: PingThread
    
    public static let defaultThreshold = 0.4
    

    public convenience init(threshold: Double = MainThreadLagDetector.defaultThreshold,
                            strictMode: Bool = false) {
        let message = "👮 Main thread was blocked for " +
            String(format:"%.2f", threshold) + "s 👮"
        
        self.init(threshold: threshold) {
            if strictMode {
                fatalError(message)
            } else {
                NSLog("%@", message)
            }
        }
    }
    
    public init(threshold: Double = MainThreadLagDetector.defaultThreshold,
                mainThreadLagDetectorFiredCallback: @escaping () -> Void) {
        
        self.pingThread = PingThread(threshold: threshold,
                                     handler: mainThreadLagDetectorFiredCallback)
        self.pingThread.start()
        super.init()
    }
    
    deinit {
        pingThread.cancel()
    }
}

fileprivate final class PingThread: Thread {
    fileprivate var pingTaskIsRunning: Bool {
        get {
            objc_sync_enter(pingTaskIsRunningLock)
            let result = _pingTaskIsRunning;
            objc_sync_exit(pingTaskIsRunningLock)
            return result
        }
        set {
            objc_sync_enter(pingTaskIsRunningLock)
            _pingTaskIsRunning = newValue
            objc_sync_exit(pingTaskIsRunningLock)
        }
    }
    private var _pingTaskIsRunning = false
    private let pingTaskIsRunningLock = NSObject()
    fileprivate var semaphore = DispatchSemaphore(value: 0)
    fileprivate let threshold: Double
    fileprivate let handler: () -> Void
    
    init(threshold: Double, handler: @escaping () -> Void) {
        self.threshold = threshold
        self.handler = handler
        super.init()
        self.name = "MainThreadLagDetector"
    }
    
    override func main() {
        while !isCancelled {
            pingTaskIsRunning = true
            DispatchQueue.main.async {
                self.pingTaskIsRunning = false
                self.semaphore.signal()
            }
            
            Thread.sleep(forTimeInterval: threshold)
            if pingTaskIsRunning {
                handler()
            }
            
            _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        }
    }
}
