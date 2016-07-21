//
//  Feed.swift
//  ReadeRSS
//
//  Created by Mate Papp on 13/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

class Feed: NSObject {
    var title: String?
    var url: NSURL?
    var category: Category?
    // TODO: icon
    
    var articles: [Article] = [Article]()
    
    init(title: String, url: NSURL, category: Category) {
        self.title = title
        self.url = url
        self.category = category
    }
    
}