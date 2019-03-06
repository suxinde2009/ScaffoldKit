//
//  SoundManagerTests.swift
//  ScaffoldKitTests
//
//  Created by SuXinDe on 2019/3/7.
//  Copyright © 2019 su xinde. All rights reserved.
//

import XCTest

class SoundManagerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        var keyExists: Bool = false
        SoundManager.shared.prepareSound(fileName: "test.mp3")
        keyExists = SoundManager.shared.sounds["test.mp3"] != nil
        
        SoundManager.shared.playSound(fileName: "test.mp3")
        
        SoundManager.shared.removeSound(fileName: "test.mp3")
        keyExists = SoundManager.shared.sounds["test.mp3"] != nil
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}



