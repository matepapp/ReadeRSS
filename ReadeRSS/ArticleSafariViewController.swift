//
//  ArticleSafariViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 14/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit
import SafariServices

class ArticleSafariViewController: SFSafariViewController, SFSafariViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the bar tint to match the UI design
        self.view.tintColor = UIColor(red: 0 / 255, green: 67 / 255, blue: 67 / 255, alpha: 1.0)
    }

    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

}
