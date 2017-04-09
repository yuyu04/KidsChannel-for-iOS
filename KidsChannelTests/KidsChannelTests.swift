//
//  KidsChannelTests.swift
//  KidsChannel
//
//  Created by sungju on 2017. 4. 6..
//  Copyright © 2017년 sungju. All rights reserved.
//

import XCTest
@testable import KidsChannel

class KidsChannelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAlbumVideoModel() {
        let list = AlbumVideoModel.listAlbumVideoModel()
        XCTAssert(list.count > 0)
        
        for video in list {
            AlbumVideoModel.getAVAsset(from: video.asset) { (avAsset, avAudioMix, dic) in
                XCTAssert(list.count > 0)
            }
        }
    }
}
