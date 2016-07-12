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
        
        // Remove the text from the back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initializeArticles() {
        for i in 1...8 {
            articles.append(Article(source: "TheNextWeb\(i)", url: NSURL(string: "https://google.com")!, date: NSDate(), title: "Google speeds past Apple in the race to train mobile app devs in India", author: "ABHIMANYU GHOSHAL", content: "In the next two years, India is slated to have the largest population of software developers in the world, at four million professionals in the industry. To that end, it’s important for companies to get in on the ground floor and capture as large a share of that focus as possible. That’s why Google has launched its Android Skilling program in the country, with a view to train two million devs in the next three years. The program includes integrating Android development into university curricula through the government’s National Skill Development Corporation of India, as well as offering an exam for globally recognized certification – priced at Rs. 6,500 ($97) that should make it easier for students to land jobs in the software sector. The company also partnered with online learning firm Udacity to offer Android nanodegrees, including a full-fledged one last year and another for beginners last month. In addition, it will make its Android Developer Fundamentals courseware open source and publicly available for free later this year. With that, Google is set to zoom past Apple in the race to build a large developer base for its mobile platform in India. In May, Apple announced that it will open a new facility in the city of Bangalore sometime in 2017 to enhance iOS designers and developers’ understanding and capabilities. Unlike Google’s program, which is set to kick off this year, Apple’s initiative is still a while away and doesn’t offer end-to-end training for would-be iOS devs. There’s a lot more scope for Google to win this race, as students won’t need iOS devices or Macs to train on and hone their skills; they can start with cheaper gear like inexpensive Android smartphones and Windows or Linux-based PCs. Plus, with training available as part of university curricul, it’s easier to begin learning to code Android software than take up lessons after school hours and on top of one’s existing course load.", icon: UIImage(named: "tnw")!, image: UIImage(named: "article1")!))
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ArticleView" {
            let destinationViewController = segue.destinationViewController as! ArticleViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destinationViewController.initializeArticle(articles[indexPath.row])
            }
            
        }
    }

}
