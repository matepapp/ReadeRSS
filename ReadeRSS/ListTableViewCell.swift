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
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    var unread: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Add blur effect
        let lightBlur = UIBlurEffect(style: .Light)
        let lightBlurView = UIVisualEffectView(effect: lightBlur)
        
        lightBlurView.frame = bgView.frame
        self.contentView.addSubview(lightBlurView)
        
        // Make the cell rounded
        self.bgView.layer.cornerRadius = 10.0
        self.bgView.layer.masksToBounds = true
        
        // Add the blur effect to the cell
        let vibrancy = UIVibrancyEffect(forBlurEffect: lightBlur)
        let vibrancyView = UIVisualEffectView(effect: vibrancy)
        lightBlurView.contentView.addSubview(vibrancyView)
        lightBlurView.contentView.addSubview(bgView)
        
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
    }
    
    // TODO: Selected cell different color

}
