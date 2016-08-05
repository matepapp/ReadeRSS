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
    @IBOutlet weak var coverImg: UIImageView!

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
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "HH:mm"
        timeLbl.text = dateFormatter.stringFromDate(article.date)

        titleLbl.text = article.title
        unread = article.unread
        
        if let cover = article.coverImg {
            coverImg.image = cover
            coverImg.layer.cornerRadius = 8.0
            coverImg.clipsToBounds = true
        }
        else {
            coverImg.removeFromSuperview()
        }
        
        if !unread {
            titleLbl.textColor = UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 0.3)
            coverImg.alpha = 0.5
        }
        else {
            titleLbl.textColor = UIColor(red: 25 / 255, green: 25 / 255, blue: 25 / 255, alpha: 0.9)
        }
        
        
        
        layoutIfNeeded()
    }
    

}
