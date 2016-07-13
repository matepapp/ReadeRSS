//
//  XMLParser.swift
//  ReadeRSS
//
//  Created by Mate Papp on 13/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireRSSParser

class XMLParser {
    var feed: Feed? = Feed()
    
    func parse(url: NSURL, handler: (Feed?) -> Void) {
        print("function - start")
        
        // A GET request to the specified URL
        Alamofire.request(.GET, url).responseRSS() { (response) -> Void in
            
            print("callback - start")
            // If we get a valid RSSFeed object from the response
            if let rssfeed: RSSFeed = response.result.value {
                self.feed!.setFeed(rssfeed.title!, link: NSURL(string: rssfeed.link!)!, desc: rssfeed.description)
            
                // Make a new article from RSSItem and add to the feed
                for item in rssfeed.items {
                    let article = Article(source: rssfeed.title!, url: NSURL(string: item.link!)!, date: item.pubDate!, title: item.title!, author: item.author, content: item.itemDescription, icon: nil, image: nil)
                    
                    self.feed!.addArticle(article)
                }
            }
            else {
                self.feed = nil
            }
            
            handler(self.feed)
            
            print("callback - end")
        }
        
        print("function - return")
    }
}
