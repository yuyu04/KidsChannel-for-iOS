//
//  KidsChannelNetworkTests.swift
//  KidsChannel
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import XCTest
@testable import KidsChannel

class KidsChannelNetworkTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestLogin() {
        let asyncExpection = expectation(description: "networkRunningFunction")
        NetworkManager.requestLogin(fromUserId: "tttt", password: "tttt") { (kindergardenName, serverMessage) in
            XCTAssert(kindergardenName.length < 1)
            asyncExpection.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            
        }
    }
    
    func testRequestUserUpdate() {
        let asyncExpection = expectation(description: "networkRunningFunction")
        NetworkManager.requestUserUpdate(userId: "tttt", password: "tttt", kindergartenName: "AAAA") { (message) in
            XCTAssert(message.length < 1)
            asyncExpection.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            
        }
    }
    
    func testRequestUserJoin() {
        let asyncExpection = expectation(description: "networkRunningFunction")
        NetworkManager.requestUserUpdate(userId: "tttt", password: "tttt", kindergartenName: "AAAA") { (message) in
            XCTAssert(message.length < 1)
            asyncExpection.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            
        }
    }
    
    func testRequestCameraSearch() {
        let asyncExpection = expectation(description: "networkRunningFunction")
        NetworkManager.requestCameraSearch(userId: "tttt") { (camera) in
            XCTAssert(camera != nil)
            asyncExpection.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            
        }
    }
    
    func testRequestViewWatch() {
        let asyncExpection = expectation(description: "networkRunningFunction")
        NetworkManager.requestViewWatch(userId: "tttt", cameraIdx: "56", viewStartTime: Date(), viewEndTime: Date())
        waitForExpectations(timeout: 10) { error in
            
        }
    }
}
