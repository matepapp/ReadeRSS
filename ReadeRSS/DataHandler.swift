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
    
    var storedFeeds = [Feed]()
    
    private init() {
        if storedFeeds.isEmpty {
            addSampleFeeds()
        }
    }
    
    func parseFeeds(handler feedsHandler: ([Feed]) -> Void) {
        var parsedFeeds = [Feed]()
        var i = 0
        
        for feed in storedFeeds {
            // TODO: Error handling
            XMLParser().parse(feed.url, category: feed.category, handler: { (feedOptional: Feed?) in
                
                i = i + 1
                
                if let feed = feedOptional {
                    // We have the data.
                    // Handle data.
                    parsedFeeds.append(feed)
                
                } else {
                    // Error happened.
                }
                
                if i == self.storedFeeds.count {
                    feedsHandler(parsedFeeds)
                }
            })
        }
    }
    
    
    // TODO: Error handling
    func documentPath() -> String {
        return NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!.URLByAppendingPathComponent("feeds").path ?? ""
    }
    
    func saveFeeds() {
        NSKeyedArchiver.archiveRootObject(self.storedFeeds, toFile: documentPath())
    }
    
    func loadStoredFeeds() {
        if let feeds = NSKeyedUnarchiver.unarchiveObjectWithFile(documentPath()) as? [Feed] {
            self.storedFeeds = feeds
        }
        // TODO: Error handling
    }
    
    
    private func addSampleFeeds() {
        let urlFeeds: [(NSURL, Category)] = [(NSURL(string: "http://www.theverge.com/apple/rss/index.xml")!, Category.Technology), (NSURL(string: "http://imagazin.hu/feed/")!, Category.Technology), (NSURL(string: "http://theartnewspaper.com/rss/")!, Category.Art), (NSURL(string: "http://www.livescience.com/home/feed/site.xml")!, Category.Animals), (NSURL(string: "https://www.theguardian.com/world/animals/rss")!, Category.Animals), (NSURL(string: "http://feeds.bbci.co.uk/news/business/rss.xml")!, Category.Business), (NSURL(string: "https://www.theguardian.com/uk/business/rss")!, Category.Business), (NSURL(string: "http://feeds.reuters.com/reuters/businessNews")!, Category.Business), (NSURL(string: "http://www.wsj.com/xml/rss/3_7014.xml")!, Category.Business)]
        
        for (url, cat) in urlFeeds {
            self.storedFeeds.append(Feed(title: nil, url: url, category: cat))
        }
    }
    
    func addFeed(url: NSURL, cat: Category) {
        storedFeeds.append(Feed(title: nil, url: url, category: cat))
        saveFeeds()
        
        NSNotificationCenter.defaultCenter().postNotificationName(dataChangedNotification, object: self)
        

    }
}
