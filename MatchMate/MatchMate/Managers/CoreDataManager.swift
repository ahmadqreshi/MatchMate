//
//  CoreDataManager.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation
import CoreData

final class CoreDataManager {
    private init() {}
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MatchMate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // NOTE: - After Setting values of NSManagedObject
    // please call saveContext() function to save the data
    func create<T: NSManagedObject>(objectType: T.Type) -> T {
        let entityName = String(describing: objectType)
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! T
        return object
    }
    
    
    func fetch<T: NSManagedObject>(objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            return try context.fetch(fetchRequest) as? [T] ?? [T]()
        } catch {
            debugPrint("Failed to fetch users: \(error)")
        }
        return [T]()
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
}
