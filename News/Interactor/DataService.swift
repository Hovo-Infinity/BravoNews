//
//  DataService.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit
import CoreData


class DataService: NSObject {
    static let sharedInstance = DataService()
    private var requestController: RequestController!

    /**
        begin fetch data grom our backend
        then save it into core data
        post notification after end fetching
     */
    func startFetchingData() {
        requestController = RequestController(url: URL(string: "https://www.helix.am/temp/json.php"))
        requestController.comletion = {[unowned self](UrlResponse, data) in
//            self.clearDatabase()
//            let json = try! JSON(data: data!)
//            for index in 0..<json["metadata"].arrayValue.count  {
//                let metaJson: JSON = json["metadata"].arrayValue[index]
//                let dictionary = News.createDictionaryForm(json: metaJson)
//                let entity = NSEntityDescription.entity(forEntityName: "News", in: DataService.viewContext())!
//                let new = NSManagedObject(entity: entity, insertInto: DataService.viewContext()) as! News
//                new.id = Int16(index)
//                new.updateValuesFrom(dictionary: dictionary)
//            }
//            DataService.saveContext()
//            let userInfo: [String: Any] = ["success": true]
        }
        requestController.failure = { (err) in
            print(err.localizedDescription)
            var userInfo: [String: Any] = [:]
            if News.allObjectsCount() != 0 {
                userInfo = ["success": true]
            } else {
                userInfo = ["success": false, "error": err]
            }
        }
        requestController.doGetRequest()
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "News")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - class functions
    
    class func viewContext() -> NSManagedObjectContext {
        return sharedInstance.persistentContainer.viewContext
    }
    
    class func saveContext() {
        sharedInstance.saveContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
