//
//  GalleryObject.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

public class GalleryObject: NSObject, NSCoding {
    
    public var title: String!
    public var thumbnailUrl: String!
    public var contentUrl: String!
    
    public required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        thumbnailUrl = aDecoder.decodeObject(forKey: "thumbnailUrl") as! String
        contentUrl = aDecoder.decodeObject(forKey: "contentUrl") as! String
    }
    
    init(title: String!, thumbnail: String!, contentUrl: String!) {
        self.title = title
        self.thumbnailUrl = thumbnail
        self.contentUrl = contentUrl
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(thumbnailUrl, forKey: "thumbnailUrl")
        aCoder.encode(contentUrl, forKey: "contentUrl")
    }
}
