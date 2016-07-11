//
//  ArticleViewController.swift
//  ReadeRSS
//
//  Created by Mate Papp on 07/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    var article: Article?
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var imageImg: UIImageView!
    @IBOutlet weak var contentTextField: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let article = self.article {
            configureArticle(article)
        }

        resizeContent()
        // Do any additional setup after loading the view.
    }
    
    func initializeArticle(article: Article) {
        self.article = article
    }
    
    func configureArticle(article: Article!) {
        // Format the date
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy HH:mm"
        
        // Set the UI elements attributes
        dateLbl.text = dateFormatter.stringFromDate(article.date)
        titleLbl.text = article.title
        authorLbl.text = "by \(article.author)"
        imageImg.image = article.image
        contentTextField.text = article.content
    }
    
    func resizeContent() {
        titleLbl.sizeToFit()
        contentTextField.sizeToFit()
        
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

}
