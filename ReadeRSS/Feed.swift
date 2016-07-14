//
//  Feed.swift
//  ReadeRSS
//
//  Created by Mate Papp on 13/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

class Feed: NSObject {
    var name: String?
    var link: NSURL?
    var desc: String?
    // TODO: icon
    
    var articles: [Article] = [Article]()
    
    func setFeed(name: String, link: NSURL, desc: String) {
        self.name = name
        self.link = link
        self.desc = desc
    }
}