//
//  Article.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

class Article: NSObject {
    var url: String
    var date: NSDate
    var title: String
    var author: String
    var content: String
    //var photo: UIImage
    
    init(url: String, date: NSDate, title: String, author: String, content: String) {
        self.url = url
        self.date = date
        self.title = title
        self.author = author
        self.content = content
    }
    
}