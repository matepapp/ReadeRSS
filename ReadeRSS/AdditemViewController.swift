//
//  AdditemViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 21/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class AdditemViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var topicPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func done(sender: AnyObject) {
        if urlTextField.hasText() {
            let presentingNavController = self.presentingViewController as! UINavigationController
            let presentingVC = presentingNavController.topViewController as! MainTableViewController
            presentingVC.urls.append(NSURL(string: urlTextField.text!)!)
            
            presentingVC.dismissViewControllerAnimated(true, completion: nil)
            
            print(presentingVC.urls)
        }
    }
}
