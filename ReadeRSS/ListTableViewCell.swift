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
    @IBOutlet weak var subtitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Configure a cell with an article
    func configureCell(article: Article) {
        sourceIconImg.image = article.icon
        sourceLbl.text = article.source
        
        // Format the date
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "HH:mm"
        timeLbl.text = dateFormatter.stringFromDate(article.date)
        
        titleLbl.text = article.title
        subtitleLbl.text = "Placeholder text for the content field"
    }

}
