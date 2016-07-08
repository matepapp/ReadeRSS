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
    var topics = ["Tech", "Sport", "Science", "Music", "Bussiness", "Entertainment", "Lifestyle", "News", "Lifestyle1", "News1", "Lifestyle2", "News2", "Lifestyle3", "News3", "Lifestyle4", "News4", "Lifestyle5", "News5", "Lifestyle6", "News6", "Lifestyle7", "News88", "Lifestyle9", "News86"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as! MainTableViewCell
            
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

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("OpenDetailedView", sender: indexPath)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinationViewController = segue.destinationViewController as UIViewController
        
        if let id = segue.identifier {
            if id == "OpenDetailedView" {
                
            }
        }
        
        // Get the cell that generated this segue.
        if let indexPath = sender as? NSIndexPath {

            var selectedItem: String?
            
            switch indexPath.section {
            case 0:
                selectedItem = menuItems[indexPath.row]
            
            case 1:
                selectedItem = topics[indexPath.row]
                
            default:
                selectedItem = nil
            }
            
            destinationViewController.navigationItem.title = selectedItem
        }
    }
 

}
