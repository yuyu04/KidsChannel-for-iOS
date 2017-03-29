//
//  KidsChannelTests.swift
//  KidsChannelTests
//
//  Created by sungju on 2017. 3. 28..
//  Copyright © 2017년 sungju. All rights reserved.
//

import XCTest
import CoreData
@testable import KidsChannel

class KidsChannelDBTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        CoreDataStack.sharedInstance.deleteAllObjects()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testImportUserEntity() {
        do {
            try DatabaseController.importUser(id: "tttt", password: "tttt")
            let request: NSFetchRequest<User> = User.fetchRequest()
            let context: NSManagedObjectContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            let searchResults = try context.fetch(request)
            if searchResults.count < 1 {
                throw KidsChannelException.InternalException("")
            }
            
            let user: User = searchResults[0]
            XCTAssert(user.id == "tttt")
            XCTAssert(user.password == "tttt")
        } catch {
            XCTAssert(false)
        }
    }
    
    func testRemoveUserEntity() {
        do {
            try DatabaseController.importUser(id: "tttt", password: "tttt")
            let request: NSFetchRequest<User> = User.fetchRequest()
            let context: NSManagedObjectContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            var searchResults = try context.fetch(request)
            if searchResults.count < 1 {
                throw KidsChannelException.InternalException("")
            }
            
            try DatabaseController.removeUser(id: "tttt")
            searchResults = try context.fetch(request)
            if searchResults.count >= 1 {
                throw KidsChannelException.InternalException("")
            }
        } catch {
            XCTAssert(false)
        }
    }
    
    func testImportCameraEntity() {
        do {
            try DatabaseController.importUser(id: "tttt", password: "tttt")
            try DatabaseController.importCamera(userId: "tttt", name: "blautest1", url: "http://")
            let request: NSFetchRequest<Camera> = Camera.fetchRequest()
            let context: NSManagedObjectContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            var searchResults = try context.fetch(request)
            XCTAssert(searchResults.count == 1)
            
            let camera: Camera = searchResults[0]
            XCTAssert(camera.name == "blautest1")
            XCTAssert(camera.user?.id == "tttt")
            
        } catch {
            XCTAssert(false)
        }
    }
    
    func testImportLicenseEntityForWrongContent() {
        do {
            try DatabaseController.importUser(id: "tttt", password: "tttt")
            try DatabaseController.importCamera(userId: "tttt2", name: "blautest1", url: "http://")
            XCTAssert(false)
            
        } catch {
            XCTAssert(true)
        }
    }
    
    func testRemoveCameraEntity() {
        do {
            try DatabaseController.importUser(id: "tttt", password: "tttt")
            try DatabaseController.importCamera(userId: "tttt", name: "blautest1", url: "http://")
            try DatabaseController.importCamera(userId: "tttt", name: "blautest2", url: "http://")
            try DatabaseController.importCamera(userId: "tttt", name: "blautest3", url: "http://")
            
            let request: NSFetchRequest<Camera> = Camera.fetchRequest()
            let context: NSManagedObjectContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            
            try DatabaseController.removeCamera(userId: "tttt", cameraName: "blautest1")
            request.predicate = NSPredicate(format: "name==%@", "blautest1")
            var searchResults = try context.fetch(request)
            XCTAssert(searchResults.count == 0)
            
            request.predicate = NSPredicate(format: "name==%@", "blautest2")
            searchResults = try context.fetch(request)
            XCTAssert(searchResults.count == 1)
        } catch {
            XCTAssert(false)
        }
    }
}
