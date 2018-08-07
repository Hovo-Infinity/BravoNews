//
//  News+CoreDataProperties.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//
//

import Foundation
import CoreData


extension News {

    static let entityName = "News"
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var body: String?
    @NSManaged public var category: String?
    @NSManaged public var coverPhotoUrl: String?
    @NSManaged public var date: Date?
    @NSManaged public var gallery: [GalleryObject]?
    @NSManaged public var shareUrl: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int16
    @NSManaged public var videoTitle: String?
    @NSManaged public var videoThumbnailUrl: String?
    @NSManaged public var videoYoutubeId: String?

}
