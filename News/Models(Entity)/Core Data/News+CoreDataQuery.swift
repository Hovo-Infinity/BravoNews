//
//  News+CoreDataQuery.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import Foundation
import CoreData

extension News {
    class func allObjects() -> [News] {
        do {
            let result: NSArray = try DataService.viewContext().fetch(NSFetchRequest(entityName: News.entityName)) as NSArray
            return result.sortedArray(using: [NSSortDescriptor.init(key: "id", ascending: true)]) as! [News]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    class func allObjectsCount() -> Int {
        var count = 0
        do {
            count = try DataService.viewContext().count(for: NSFetchRequest(entityName: News.entityName))
        } catch {
            print(error.localizedDescription)
        }
        return count
    }
    
    class func objectForIndex(index: Int16) -> News? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: News.entityName)
        fetchRequest.predicate = NSPredicate(format: "id = \(index)")
        do {
            let result = try DataService.viewContext().fetch(fetchRequest)
            return result.first as? News
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    /**
     clear all objects in core data
     */
    class func clearDatabase() {
        let fetchRequest: NSFetchRequest = News.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try DataService.viewContext().execute(deleteRequest)
            DataService.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
