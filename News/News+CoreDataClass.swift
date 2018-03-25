//
//  News+CoreDataClass.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//
//

import Foundation
import CoreData
import SwiftyJSON

@objc(News)
public class News: NSManagedObject {
    public func updateValuesFrom(dictionary: Dictionary<String, Any>) {
        category = dictionary["category"] as? String
        title = dictionary["title"] as? String
        body = dictionary["body"] as? String
        shareUrl = dictionary["shareUrl"] as? String
        coverPhotoUrl = dictionary["coverPhotoUrl"] as? String
        date = dictionary["date"] as? Date
        gallery = dictionary["gallery"] as? [GalleryObject]
        videoTitle = dictionary["videoTitle"] as? String
        videoThumbnailUrl = dictionary["videoThumbnailUrl"] as? String
        videoYoutubeId = dictionary["videoYoutubeId"] as? String
    }
    
    class func createDictionaryForm(json: JSON) -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["category"] = json["category"].stringValue
        dictionary["title"] = json["title"].stringValue
        dictionary["body"] = json["body"].stringValue
        dictionary["shareUrl"] = json["shareUrl"].stringValue
        dictionary["coverPhotoUrl"] = json["coverPhotoUrl"].stringValue
        dictionary["date"] = Date(timeIntervalSince1970: json["date"].doubleValue)
        var array: [GalleryObject] = []
        for galleryJson in json["gallery"].arrayValue {
            let galleryObject = GalleryObject(title: galleryJson["title"].stringValue, thumbnail: galleryJson["thumbnailUrl"].stringValue, contentUrl: galleryJson["contentUrl"].stringValue)
            array.append(galleryObject)
        }
        dictionary["gallery"] = array
        let videoJson = json["video"].arrayValue.first
        dictionary["videoTitle"] = videoJson?["title"].stringValue
        dictionary["videoThumbnailUrl"] = videoJson?["thumbnailUrl"].stringValue
        dictionary["videoYoutubeId"] = videoJson?["youtubeId"].stringValue
        return dictionary
    }
    
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
}
