//
//  NewsList.swift
//  News
//
//  Created by Hovhannes Stepanyan on 8/7/18.
//  Copyright © 2018 David Varosyan. All rights reserved.
//

import Foundation
import CoreData

class NewsList: Decodable {
    private var items = [News]()
    
    enum CodingKeys: String, CodingKey {
        case items = "metadata"
    }
}
