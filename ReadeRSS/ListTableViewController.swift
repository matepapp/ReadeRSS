//
//  ListTableViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    var sections = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the self-sizing cells
        self.tableView.estimatedRowHeight = 150.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // Remove the text from the back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initializeSections(feed: Feed) {
        // Initialize a calendar instance
        let calendar = NSCalendar.currentCalendar()
        
        let orderedFeedArticles = feed.articles.sort { (a, b) -> Bool in
            return a.date.compare(b.date) == NSComparisonResult.OrderedDescending
        }
        
        for article in orderedFeedArticles {
            // Flag boolean variable to show if we added an article to a section
            var flag: Bool = false
            
            // Iterate through the sections and if the article's day is the same as the section's day put it into that section and set the flag
            for section in sections {
                if calendar.isDate(article.date, inSameDayAsDate: section.date) {
                    section.articles.append(article)
                    flag = true
                }
            }
            
            // After we checked every section and there is no place for the article add a new section with that date
            if !flag {
                sections.append(Section(date: article.date))
                sections.last!.articles.append(article)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // Numbers of rows per each section
        return sections[section].articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! ListTableViewCell
        
        // Configure the cell with the selected article in the section
        cell.configureCell(sections[indexPath.section].articles[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        sections[indexPath.section].articles[indexPath.row].unread = false
        
        
        // Initialize a SafariViewController with the selected row's URL
        let articleVC = ArticleSafariViewController(URL: sections[indexPath.section].articles[indexPath.row].url, entersReaderIfAvailable: true)
        self.presentViewController(articleVC, animated: true, completion: nil)
    }
    

}
