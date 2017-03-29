//
//  CoreDataStack.swift
//  PallyConFPSSDK
//
//  Created by sungju on 2017. 1. 18..
//  Copyright © 2017년 sungju. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()
    
    private init() {}
    
    lazy var applicationDocumentsDirectory: URL = {
        #if os(iOS)
            let documentsPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
            return documentsPath
        #elseif os(tvOS)
            let cachePath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])
            return cachePath
        #endif
    } ()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        /*
         This property is not optional. It is a fatal error for the application
         not to be able to find and load its model.
         */
        let pallyConFPSModel = Bundle(identifier: "com.inka.kidschannel")
        let modelURL: URL? = pallyConFPSModel?.url(forResource: "KidsChannel", withExtension: "momd")
        return NSManagedObjectModel(contentsOf: modelURL!)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        /*
         This implementation creates and return a coordinator, having added the
         store for the application to it. (The directory for the store is created, if necessary.)
         */
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            let options = [
                NSMigratePersistentStoresAutomaticallyOption: true,
                NSInferMappingModelAutomaticallyOption: true
            ]
            
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.storeURL, options: options)
        }
        catch {
            fatalError("Could not add the persistent store: \(error).")
        }
        
        return persistentStoreCoordinator
        
    }()
    
    /// URL for the main Core Data store file.
    lazy var storeURL: URL = {
        return self.applicationDocumentsDirectory.appendingPathComponent("KidsChannel.sqlite")
    }()
    
    func createPrivateQueueContext() throws -> NSManagedObjectContext {
        
        // Stack uses the same store and model, but a new persistent store coordinator and context.
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: CoreDataStack.sharedInstance.managedObjectModel)
        
        /*
         Attempting to add a persistent store may yield an error--pass it out of
         the function for the caller to deal with.
         */
        let storeOptions = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: CoreDataStack.sharedInstance.storeURL, options: storeOptions)
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        context.performAndWait() {
            
            context.persistentStoreCoordinator = coordinator
            
            // Avoid using default merge policy in multi-threading environment:
            // when we delete (and save) a record in one context,
            // and try to save edits on the same record in the other context before merging the changes,
            // an exception will be thrown because Core Data by default uses NSErrorMergePolicy.
            // Setting a reasonable mergePolicy is a good practice to avoid that kind of exception.
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            
            // In OS X, a context provides an undo manager by default
            // Disable it for performance benefit
            context.undoManager = nil
        }
        
        return context
    }
    
    func deleteAllObjects() {
        if let entitiesByName = persistentStoreCoordinator?.managedObjectModel.entitiesByName {
            for (entity, _) in entitiesByName {
                do {
                    try deleteAllObjectsForEntity(entity: entity)
                } catch {
                    print("Error: \(error) failed to delete SmartNetsync Core Data")
                }
            }
        }
    }
    
    func deleteAllObjectsForEntity(entity: String) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        fetchRequest.fetchBatchSize = 50
        
        let context = try self.createPrivateQueueContext()
        let entities = try context.fetch(fetchRequest) as! [NSManagedObject]
        
        for object in entities {
            context.delete(object)
        }
        
        try context.save()
    }
    
}
