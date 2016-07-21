//
//  AdditemViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 21/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class AdditemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var topicPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topicPicker.dataSource = self
        self.topicPicker.delegate = self

        // Do any additional setup after loading the view.
    }


    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let presetingVC = getPresentingViewController() {
            return presetingVC.topics.count
        }
        
        else {
            return 0
        }
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let presentingVC = getPresentingViewController() {
            return "\(presentingVC.topics[row])"
        }
        
        else {
            return nil
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getPresentingViewController() -> MainTableViewController? {
        let presentingNavController = self.presentingViewController as! UINavigationController
        let presentingVC = presentingNavController.topViewController as! MainTableViewController
        
        return presentingVC
    }

    @IBAction func cancel(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func done(sender: AnyObject) {
        if urlTextField.hasText() {
            
            if let presetingVC = getPresentingViewController() {
                presetingVC.urls.append(NSURL(string: urlTextField.text!)!)
                
                presetingVC.dismissViewControllerAnimated(true, completion: nil)
                
                print(presetingVC.urls)
            }
        }
    }
}
