//
//  MainTableViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

let dataChangedNotification = "dataChanged"

class MainTableViewController: UITableViewController {
    // MARK: Variables
    var menuItems = ["All", "Unread", "Saved"]
    var topics = Category.allValues
    
    var feeds = [Feed]()

    var selectedIndex: NSIndexPath? = nil
    var selectedFeeds: [Feed]? = nil
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        initializeFeeds()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "initializeFeeds", name: dataChangedNotification, object: nil)
    }
    
    func initializeFeeds() {
        // Setup loading screen.
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        DataHandler.instance.loadStoredFeeds()
        
        DataHandler.instance.parseFeeds { (feeds) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            self.feeds = feeds
            self.tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the background image
        let bgImageView = UIImageView(image: UIImage(named: "background1")!)
        bgImageView.contentMode = .ScaleAspectFill
        self.tableView.backgroundView = bgImageView
        
        // Customize the navigationbar
        let navBar = self.navigationController?.navigationBar
        if let navigationBar = navBar {
            navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            navigationBar.shadowImage = UIImage()
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feeds.count == 0 {
            return 0
        }
        else {
            switch section {
            case 0:
                return menuItems.count
                
            case 1:
                return topics.count + (selectedFeeds?.count ?? 0)
            default:
                return 0
            }
        }

    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableview")
        
        // Reuse the cells with the identifier mainCell
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainTableViewCell
        
        // Initialize the cells in the first section
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.configureCell(UIImage(named: "all")!, title: menuItems[indexPath.row], number: calculateArticles())
                
            case 1:
                cell.configureCell(UIImage(named: "unread")!, title: menuItems[indexPath.row], number: calculateAllUnreadArticles())
                
            case 2: fallthrough
            default:
                cell.configureCell(UIImage(named: "saved")!, title: menuItems[indexPath.row], number: 0)
            }
            
        // Initialize the second section's topics
        case 1:
            if let selectedIndex = selectedIndex {
                if calculateSelectedIndexPaths(selectedIndex).contains(indexPath) {
                    cell.configureCell(UIImage(named: "placeholder_icon"), title: selectedFeeds![indexPath.row - selectedIndex.row - 1].title!, number: calculateUnreadArticles(selectedFeeds![indexPath.row - selectedIndex.row - 1]))
                    cell.accessoryType = UITableViewCellAccessoryType.None
                } else {
                    let num = indexPath.row - selectedFeeds!.count
                    if num < 0 {
                        cell.configureCell(UIImage(named: "down"), title: "\(topics[indexPath.row])", number: calculateUnreadArticlesPerCategory(topics[indexPath.row]))
                    }
                    else {
                        cell.configureCell(UIImage(named: "down"), title: "\(topics[num])", number: calculateUnreadArticlesPerCategory(topics[num]) )
                    }
                    
                }
            } else {
                cell.configureCell(UIImage(named: "down"), title: "\(topics[indexPath.row])", number: calculateUnreadArticlesPerCategory(topics[indexPath.row]) )
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            
        default:
            cell.configureCell(nil, title: "Default", number: 0)
        }
        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // If there is no row selected, select one
        if selectedIndex == nil {
            if indexPath.section == 1 {
                // Insert as many rows as we need
                insertRows(indexPath)
            } else {
                self.performSegueWithIdentifier("ListTableView", sender: indexPath)
            }
        }
            
        // If there is a row selected and we want to select that one again
        else if selectedIndex == indexPath {
            // Delete the previously inserted rows to collapse the topic
            deleteRows()
        }
            
        // There is another row selected
        else {
            if calculateSelectedIndexPaths(selectedIndex!).contains(indexPath) || indexPath.section == 0 {
                self.performSegueWithIdentifier("ListTableView", sender: indexPath)
            }
            else {
                if let offset = selectedFeeds?.count {
                    // Delete the previously inserted rows to collapse the other topic
                    deleteRows()
                    
                    // Insert new rows to the freshly selected topic
                    if indexPath.row - offset < 0 {
                        insertRows(indexPath)
                    }
                    else {
                        insertRows(NSIndexPath(forRow: indexPath.row - offset, inSection: indexPath.section))
                    }
                }
            }

        }
        
    }
    
    // An insertion function which insert as many rows as we need from the index
    func insertRows(index: NSIndexPath) {
        // The selected index will be the indexPath
        selectedIndex = index
        
        guard let selectedIndex = selectedIndex else {
            return
        }
        
        // Calculate the selected feeds depending on the selected index
        selectedFeeds = selectFeedsFromCategory(topics[selectedIndex.row]) ?? [Feed]()
        
        // Insert the rows to the selected indexPaths
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths(calculateSelectedIndexPaths(selectedIndex), withRowAnimation: UITableViewRowAnimation.Top)
        tableView.endUpdates()
    }
    
    // A delete function which is delete the previously inserted rows
    func deleteRows() {
        guard let selectedIndex = selectedIndex else {
            return
        }
        // Delete the rows from the previously selected topic
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths(calculateSelectedIndexPaths(selectedIndex), withRowAnimation: UITableViewRowAnimation.Top)
        // Restore the selected variables because nothing is selected
        self.selectedIndex = nil
        self.selectedFeeds = nil
        tableView.endUpdates()

    }
    
    func selectFeedsFromCategory(cat: Category) -> [Feed]? {
        return feeds.filter({ (feed) -> Bool in
            return feed.category == cat
        })
    }
    
    func calculateSelectedIndexPaths(index: NSIndexPath) -> [NSIndexPath] {
        var indexes = [NSIndexPath]()

        for num in 0 ..< (selectedFeeds?.count ?? 0) {
            indexes.append(NSIndexPath(forRow: (index.row + num + 1), inSection: 1))
        }
 
        return indexes
    }
    
    func calculateUnreadArticles(feed: Feed) -> Int {
        var unreadArticles = 0
        
        for article in feed.articles {
            if article.unread {
                unreadArticles += 1
            }
        }
        
        return unreadArticles
    }
    
    func calculateUnreadArticlesPerCategory(category: Category) -> Int {
        var unreadArticlesPerCategory = 0
        
        for feed in feeds {
            if feed.category == category {
                unreadArticlesPerCategory += calculateUnreadArticles(feed)
            }
        }
        
        return unreadArticlesPerCategory
    }
    
    func calculateAllUnreadArticles() -> Int {
        var unreadArticles = 0
        
        for feed in feeds {
            unreadArticles += calculateUnreadArticles(feed)
        }
        
        return unreadArticles
    }
    
    func calculateArticles() -> Int {
        var articlesNumber = 0
        
        for feed in feeds {
            for _ in feed.articles {
                articlesNumber += 1
            }
        }
        
        return articlesNumber
    }
    
        
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ListTableView" {
            let destinationViewController = segue.destinationViewController as! ListTableViewController
            
            // Get the index that generated this segue.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var selectedItem: Feed?
                
                //                switch indexPath.section {
                //                case 0:
                //                    selectedItem = menuItems[indexPath.row]
                //
                //                case 1:
                //                    selectedItem = topics[indexPath.row]
                //
                //                default:
                //                    selectedItem = nil
                //                }
                
                selectedItem = feeds[indexPath.row % 7]
                
                // Set the title of the destinationViewController to the selected cell's title
                destinationViewController.navigationItem.title = selectedItem!.title
                
                // Pass the feed to the ListViewController and initialize the Sections with it
                destinationViewController.initializeSections(selectedItem!)
            }
        }
        
        if segue.identifier == "addNewRSS" {
            let destinationViewController = segue.destinationViewController as! AdditemViewController
            destinationViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
}
