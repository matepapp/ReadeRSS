//
//  Feed.swift
//  ReadeRSS
//
//  Created by Mate Papp on 13/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

class Feed: NSObject, NSCoding {
    var title: String?
    var url: NSURL = NSURL()
    var category: Category = Category.Animals
    // TODO: icon
    
    var articles: [Article] = [Article]()
    
    init(title: String?, url: NSURL, category: Category) {
        self.title = title
        self.url = url
        self.category = category
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.url = (aDecoder.decodeObjectForKey("feedUrl") as? NSURL)!
        self.category = categoryFromString(aDecoder.decodeObjectForKey("feedCategory") as? String)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.url, forKey: "feedUrl")
        aCoder.encodeObject("\(self.category)", forKey: "feedCategory")
    }
    
    // TODO: Error handling
    func categoryFromString(string: String?) -> Category? {
        for cat in Category.allValues {
            let catString = "\(cat)"
            if catString == string {
                return cat
            }
        }
        return Category.Animals
    }
}