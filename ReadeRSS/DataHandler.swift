//
//  DataHandler.swift
//  ReadeRSS
//
//  Created by Mate Papp on 21/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

// A Singleton class to initialize and modify the data
class DataHandler {
    // The instance of the DataHandler
    static let instance = DataHandler()
    
    var urlFeeds = [(NSURL, Category)]()
    
    private init() {
        addSampleFeeds()
    }
    
    func loadFeeds(handler feedsHandler: ([Feed]) -> Void) {
        var feeds = [Feed]()
        var i = 0
        
        for (url, category) in urlFeeds {
            // TODO: Error handling
            XMLParser().parse(url, category: category, handler: { (feedOptional: Feed?) in
                
                i = i + 1
                
                if let feed = feedOptional {
                    // We have the data.
                    // Handle data.
                    feeds.append(feed)
                
                } else {
                    // Error happened.
                }
                
                if i == self.urlFeeds.count {
                    feedsHandler(feeds)
                }
            })
        }
    }
    
    func reloadFeeds() {
        
    }
    
    private func addSampleFeeds() {
        urlFeeds = [(NSURL(string: "http://www.theverge.com/apple/rss/index.xml")!, Category.Technology), (NSURL(string: "http://imagazin.hu/feed/")!, Category.Technology), (NSURL(string: "http://www.artnews.com/feed/")!, Category.Art), (NSURL(string: "http://theartnewspaper.com/rss/")!, Category.Art), (NSURL(string: "http://www.livescience.com/home/feed/site.xml")!, Category.Animals), (NSURL(string: "https://www.theguardian.com/world/animals/rss")!, Category.Animals), (NSURL(string: "http://feeds.bbci.co.uk/news/business/rss.xml")!, Category.Business), (NSURL(string: "https://www.theguardian.com/uk/business/rss")!, Category.Business), (NSURL(string: "http://feeds.reuters.com/reuters/businessNews")!, Category.Business), (NSURL(string: "http://www.wsj.com/xml/rss/3_7014.xml")!, Category.Business)]
    }
    
    func addFeed(url: NSURL, category: Category) {
        urlFeeds.append((url, category))
        
        NSNotificationCenter.defaultCenter().postNotificationName(dataChangedNotification, object: self)
    }
}
