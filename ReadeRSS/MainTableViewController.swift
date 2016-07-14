//
//  MainTableViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var menuItems = ["All", "Unread", "Saved"]
    var topics = ["Tech", "Sport", "Science", "Music", "Bussiness", "Entertainment", "Lifestyle", "News"]
    var feeds = [Feed]()
    var urls = [NSURL(string: "http://www.theverge.com/apple/rss/index.xml"), NSURL(string: "http://www.economist.com/rss/"), NSURL(string: "http://feeds.feedburner.com/techcrunch"), NSURL(string: "http://lifehacker.com/index.xml"), NSURL(string: "http://imagazin.hu/feed/"), NSURL(string: "http://index.hu/24ora/rss/")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the text from the back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        initializeFeeds()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeFeeds() {
        // Setup loading screen.
        
        for url in urls {
            // TODO: Error handling
            let XMLParserObject = XMLParser()
            XMLParserObject.parse(url!, handler: { (feedOptional: Feed?) in
                if let feed = feedOptional {
                    // We have the data.
                    // Handle data.
                    self.feeds.append(feed)
                    
                    // Setup normal state.
                    self.tableView.reloadData()
                    
                } else {
                    // Error happened.
                }
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case 0:
            return menuItems.count
            
        case 1:
            return topics.count
        default:
            return 0
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
                let icon = UIImage(named: "all")!
                let random = Int(arc4random_uniform(120) + 1)
                cell.configureCell(icon, title: menuItems[indexPath.row], number: random)
                
            case 1:
                let icon = UIImage(named: "unread")!
                let random = Int(arc4random_uniform(120) + 1)
                cell.configureCell(icon, title: menuItems[indexPath.row], number: random)
                
            case 2: fallthrough
            default:
                let icon = UIImage(named: "saved")!
                let random = Int(arc4random_uniform(120) + 1)
                cell.configureCell(icon, title: menuItems[indexPath.row], number: random)
            }
            
        // Initialize the second section's topics
        case 1:
            let icon = UIImage(named: "down")
            let random = Int(arc4random_uniform(120) + 1)
            cell.configureCell(icon, title: topics[indexPath.row], number: random)
            cell.accessoryType = UITableViewCellAccessoryType.None
            
        default:
            cell.configureCell(nil, title: "Default", number: 0)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Menu"
        
        case 1:
            return "Topics"
        default:
            return nil
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
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
                
                selectedItem = feeds[indexPath.row % urls.count]
                
                // Set the title of the destinationViewController to the selected cell's title
                destinationViewController.navigationItem.title = selectedItem!.name
                
                // Pass the feed to the ListViewController and initialize the Sections with it
                destinationViewController.initializeSections(selectedItem!)
            }
        }

    }
 
}
