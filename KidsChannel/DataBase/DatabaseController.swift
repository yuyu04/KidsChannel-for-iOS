//
//  DatabaseController.swift
//  PallyConFPSSDK
//
//  Created by sungju on 2017. 1. 18..
//  Copyright © 2017년 sungju. All rights reserved.
//

import CoreData

class DatabaseController {
    
    static func importUser(id: String, password: String) throws {
        let taskContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        var processContextError: KidsChannelException?
        
        taskContext.performAndWait {
            let existing: [User]
            request.predicate = NSPredicate(format: "%K == %@", "id", id)
            do {
                existing = try taskContext.fetch(request)
            } catch {
                processContextError = KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not fetch from the store")
                return
            }
            
            if existing.count < 1 {
                let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: taskContext) as! User
                user.id = id
                user.password = password
            } else {
                // 동일한 고객이 존재할 경우 필드 값들을 업데이트 한다.
                let user = existing[0]
                user.id = id
                user.password = password
            }
            
            do {
                try taskContext.save()
            } catch {
                processContextError = KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not save Core Data context.")
            }
            
            taskContext.reset()
        }
        
        if processContextError != nil {
            throw processContextError!
        }
    }
    
    static func importCamera(userId: String, name: String, url: String) throws {
        let taskContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
        
        let userRequest: NSFetchRequest<User> = User.fetchRequest()
        let cameraRequest: NSFetchRequest<Camera> = Camera.fetchRequest()
        
        var processContextError: KidsChannelException?
        
        taskContext.performAndWait {
            let existingCamera: [Camera]
            
            cameraRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@", "user.id", userId, "name", name)
            
            do {
                existingCamera = try taskContext.fetch(cameraRequest)
            } catch {
                processContextError = KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not fetch from the store")
                return
            }
            
            if existingCamera.count < 1 {
                // userId 와 동일한 고객 필드를 얻어와 콘텐트 필드에 설정한다.
                let existingUser: [User]
                
                userRequest.predicate = NSPredicate(format: "%K == %@", "id", userId)
                
                do {
                    existingUser = try taskContext.fetch(userRequest)
                } catch {
                    processContextError = KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not fetch from the store")
                    return
                }
                
                if existingUser.count < 1 {
                    processContextError = KidsChannelException.DatabaseProcessError("user data is nothing. userId = \(userId)")
                    return
                }
                
                let user: User = existingUser[0]
                
                let camera = NSEntityDescription.insertNewObject(forEntityName: "Camera", into: taskContext) as! Camera
                camera.name = name
                camera.url = url
                camera.user = user
            } else {
                // 동일한 콘텐트가 존재 할 경우 업데이트를 진행한다.
                let camera = existingCamera[0]
                camera.name = name
                camera.url = url
                print("CameraEntity update...")
            }
            
            do {
                try taskContext.save()
            } catch {
                processContextError = KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not save Core Data context.")
            }
            
            taskContext.reset()
        }
        
        if processContextError != nil {
            throw processContextError!
        }
    }
    
    static func removeUser(id: String) throws {
        do {
            let taskContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            let request: NSFetchRequest<User> = User.fetchRequest()
            
            if id.characters.count > 0 {
                request.predicate = NSPredicate(format: "%K == %@", "id", id)
            }
            
            let entities = try taskContext.fetch(request)
            
            for object in entities {
                taskContext.delete(object)
            }
            
            try taskContext.save()
            taskContext.reset()
        } catch {
            throw KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not remove customer entity. id = \(id)")
        }
    }
    
    static func removeCamera(userId: String, cameraName: String) throws {
        do {
            let taskContext = try CoreDataStack.sharedInstance.createPrivateQueueContext()
            let request: NSFetchRequest<Camera> = Camera.fetchRequest()
            
            if userId.characters.count > 0, cameraName.characters.count > 0 {
                request.predicate = NSPredicate(format: "%K == %@ AND %K == %@", "user.id", userId, "name", cameraName)
            }
            
            let entities = try taskContext.fetch(request)
            if entities.count < 1 {
                return
            }
            
            taskContext.delete(entities[0])
            
            try taskContext.save()
            taskContext.reset()
        } catch {
            throw KidsChannelException.DatabaseProcessError("Error: \(error)\nCould not remove license entity. userId = \(userId) cameraName = \(cameraName)")
        }
    }
}
