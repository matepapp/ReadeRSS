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
    @IBOutlet weak var categoryBtn: UIButton!

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
        return Category.allValues.count
    }
    
    // MARK: UIPickerViewDelegate
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = "\(Category.allValues[row])"
        return NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: IBActions

    @IBAction func selectCategory(sender: AnyObject) {
        categoryBtn.hidden = true
        topicPicker.hidden = false
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func done(sender: AnyObject) {
        if urlTextField.hasText() {
            DataHandler.instance.addFeed(NSURL(string: urlTextField.text!)!, cat: Category.allValues[topicPicker.selectedRowInComponent(0)])
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            print(DataHandler.instance.storedFeeds)
        }
    }
}
