//
//  Article.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation
import UIKit

class Article: NSObject {
    var source: String
    var url: NSURL
    var date: NSDate
    var title: String
    var author: String
    var content: String
    var icon: UIImage?
    var image: UIImage?
    
    init(source: String, url: NSURL, date: NSDate, title: String, author: String?, content: String?, icon: UIImage?, image: UIImage?) {
        self.source = source
        self.url = url
        self.date = date
        self.title = title
        self.author = author ?? "Placeholder Author"
        self.content = content ?? "Somebody forgot to fill the content field"
        self.icon = icon ?? UIImage(named: "placeholder_icon")
        self.image = image ?? UIImage(named: "placeholder_img")
    }
}