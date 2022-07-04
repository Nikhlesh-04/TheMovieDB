//
//  CoreDataStack.swift
//  TheMovieDB
//
//  Created by Nikhlesh bagdiya on 03/07/22.
//

import Foundation
import CoreData
import UIKit

enum CoreDataOperation {
    case success
    case failed
}

class CoreDataStack {
    
    static let shared = CoreDataStack(modelName: "TheMovieDB")
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    func saveContext() -> CoreDataOperation {
        let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                    return .success
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        return .failed
    }
    
    func fetchEntities<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description())
            do {
                
                if let predicateForFetch = predicate {
                    fetchRequest.predicate = predicateForFetch
                }
                
                if let sortForFetch = sortDescriptors {
                    fetchRequest.sortDescriptors = sortForFetch
                }
                
                // Get a reference to a NSManagedObjectContext
                let context = managedContext
                // Perform the fetch request to get the objects
                // matching the predicate
                let objects = try context.fetch(fetchRequest)
                
                return objects as? [T]
                
            } catch let error {
                print("Error while fetch object: \(error.localizedDescription)")
            }
        return nil
    }
    
    @discardableResult func deleteAllRecord<T: NSManagedObject>(entity: T.Type) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description())
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        // Get a reference to a NSManagedObjectContext
        let context = managedContext
        // Perform the fetch request to get the objects
        // matching the predicate
        do {
             try context.execute(deleteRequest)
             try context.save()
                return true
        } catch let error {
            print("Error while deleting all objects: \(error.localizedDescription)")
        }
        return false
    }
    
    func showAlert(messsage:String, conroller:UIViewController) {
        let alertController = UIAlertController(title: "TheMovieDB", message: messsage, preferredStyle: UIAlertController.Style.alert)
        
        let saveAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { alert -> Void in
        })
        
        alertController.addAction(saveAction)
        
        conroller.present(alertController, animated: true, completion: nil)
    }
    
    func isObjectExist<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity.description())
        fetchRequest.predicate = predicate
        
        // Get a reference to a NSManagedObjectContext
        let context = managedContext
        
        do {
            let count = try context.count(for: fetchRequest)
             return count > 0
        } catch let error {
            print("Error while deleting all objects: \(error.localizedDescription)")
        }
        return false
        
    }
}
