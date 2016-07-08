//
//  MainTableViewCell.swift
//  ReadeRSS
//
//  Created by Mate Papp on 08/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Configure the custom cell
    func configureCell(icon: UIImage?, title: String, number: Int) {
        iconImg.image = icon ?? UIImage(named: "all")
        titleLbl.text = title
        counterLbl.text = String(number)
    }

}
