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
    
    func parse(url: NSURL, category: Category, handler: (Feed?) -> Void) {
        print("function - start")
        var feed: Feed?
        
        // A GET request to the specified URL
        Alamofire.request(.GET, url).responseRSS() { (response) -> Void in
            
            print("callback - start")
            
            // If we get a valid RSSFeed object from the response
            // TODO: Error handling when force unwrapping the values of the feed
            if let rssfeed: RSSFeed = response.result.value {
                feed = Feed(title: rssfeed.title!, url: NSURL(string: rssfeed.link!)!, category: category)
            
                // Make a new article from RSSItem and add to the feed
                for item in rssfeed.items {
                    let article = Article(source: rssfeed.title!, url: NSURL(string: item.link!)!, date: item.pubDate!, title: item.title!, icon: nil)
                    
                    feed!.articles.append(article)
                }
                
                print(rssfeed.title)
            }
            else {
                feed = nil
            }

            handler(feed)
            
            print("callback - end")
            
        }
        
        print("function - return")
    }
}
