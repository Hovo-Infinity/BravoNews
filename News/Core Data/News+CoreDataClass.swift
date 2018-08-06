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

@objc(News)
public class News: NSManagedObject, Decodable {
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        let managedObjectContext = DataService.viewContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "News", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.body = try container.decodeIfPresent(String.self, forKey: .body)
        self.shareUrl = try container.decodeIfPresent(String.self, forKey: .shareUrl)
        self.coverPhotoUrl = try container.decodeIfPresent(String.self, forKey: .coverPhotoUrl)
        self.date = try container.decodeIfPresent(Date.self, forKey: .date)
//        self.gallery = try container.decodeIfPresent(Array.self, forKey: .gallery)
        self.videoTitle = try container.decodeIfPresent(String.self, forKey: .videoTitle)
        self.videoThumbnailUrl = try container.decodeIfPresent(String.self, forKey: .videoThumbnailUrl)
        self.videoYoutubeId = try container.decodeIfPresent(String.self, forKey: .videoYoutubeId)
    }
    
//    public func updateValuesFrom(dictionary: Dictionary<String, Any>) {
//        category = dictionary["category"] as? String
//        title = dictionary["title"] as? String
//        body = dictionary["body"] as? String
//        shareUrl = dictionary["shareUrl"] as? String
//        coverPhotoUrl = dictionary["coverPhotoUrl"] as? String
//        date = dictionary["date"] as? Date
//        gallery = dictionary["gallery"] as? [GalleryObject]
//        videoTitle = dictionary["videoTitle"] as? String
//        videoThumbnailUrl = dictionary["videoThumbnailUrl"] as? String
//        videoYoutubeId = dictionary["videoYoutubeId"] as? String
//    }
//
//    class func createDictionaryForm(json: JSON) -> [String: Any] {
//        var dictionary: [String: Any] = [:]
//        dictionary["category"] = json["category"].stringValue
//        dictionary["title"] = json["title"].stringValue
//        dictionary["body"] = json["body"].stringValue
//        dictionary["shareUrl"] = json["shareUrl"].stringValue
//        dictionary["coverPhotoUrl"] = json["coverPhotoUrl"].stringValue
//        dictionary["date"] = Date(timeIntervalSince1970: json["date"].doubleValue)
//        var array: [GalleryObject] = []
//        for galleryJson in json["gallery"].arrayValue {
//            let galleryObject = GalleryObject(title: galleryJson["title"].stringValue, thumbnail: galleryJson["thumbnailUrl"].stringValue, contentUrl: galleryJson["contentUrl"].stringValue)
//            array.append(galleryObject)
//        }
//        dictionary["gallery"] = array
//        let videoJson = json["video"].arrayValue.first
//        dictionary["videoTitle"] = videoJson?["title"].stringValue
//        dictionary["videoThumbnailUrl"] = videoJson?["thumbnailUrl"].stringValue
//        dictionary["videoYoutubeId"] = videoJson?["youtubeId"].stringValue
//        return dictionary
//    }
//
    enum CodingKeys: String, CodingKey {
        case category
        case title
        case body
        case shareUrl
        case coverPhotoUrl
        case date
        case gallery
        case videoTitle
        case videoThumbnailUrl
        case videoYoutubeId
    }
    
    
}
