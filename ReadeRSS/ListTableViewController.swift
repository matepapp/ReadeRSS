//
//  ListTableViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeArticles()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initializeArticles() {
        for i in 1...8 {
            articles.append(Article(source: "FamousPortal\(i)", url: NSURL(string: "https://google.com")!, date: NSDate(), title: "A very long title which hopefully takes more than 2 rows", author: "John Doe", content: "\(i) This will be a longer text. Firmament was. Seasons in great you'll place god together second gathered blessed great man divided under, seed from third two. Face. Man moved gathered days sixth whales. Called dry. Give place likeness. Creepeth can't to brought unto don't creeping land seasons don't divide without, had moved image lights and so it first herb set life. Tree first land.Over beginning living replenish i heaven. One fish given a seasons moving hath. Whose over have seas second fruit lesser you seasons appear under sixth replenish, over moving saying kind, had air dominion. Lights. Creepeth, to so our the. Were creepeth said.", icon: UIImage(named: "placeholder")!))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        // TODO: Implement more section for the specific date
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // TODO: count the numbers/section depending on date
        return articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! ListTableViewCell
        cell.configureCell(articles[indexPath.row])
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Today"
            
        case 1:
            return "Yesterday"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
