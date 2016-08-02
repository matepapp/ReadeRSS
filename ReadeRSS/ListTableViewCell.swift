//
//  ListTableViewCell.swift
//  ReadeRSS
//
//  Created by Mate Papp on 08/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var sourceIconImg: UIImageView!
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!

    var unread: Bool = true
    var saved: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        // Make the cell rounded
        visualEffectView.layer.cornerRadius = 9.0
        visualEffectView.clipsToBounds = true

    }
    
    // Configure a cell with an article
    func configureCell(article: Article) {
        sourceIconImg.image = article.icon
        sourceLbl.text = article.source.uppercaseString
        
        // Format the date
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "HH:mm"
        timeLbl.text = dateFormatter.stringFromDate(article.date)
        
        titleLbl.text = article.title
        
        self.unread = article.unread
        
        if !unread {
            titleLbl.textColor = UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 0.3)
        }
        else {
            titleLbl.textColor = UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 0.9)
        }
        
        if saved {
            titleLbl.textColor = UIColor(red: 238 / 255, green: 244 / 255, blue: 56 / 255, alpha: 0.9)
        }
        
        else {
            titleLbl.textColor = UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 0.9)
        }
        
        layoutIfNeeded()
    }
    

}
