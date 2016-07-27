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
    let source: String
    let url: NSURL
    let date: NSDate
    let title: String
    var unread: Bool = true
    var icon: UIImage?
    
    init(source: String, url: NSURL, date: NSDate, title: String, icon: UIImage?) {
        self.source = source
        self.url = url
        self.date = date
        self.title = title
        self.icon = icon ?? UIImage(named: "placeholder_icon")
    }
}