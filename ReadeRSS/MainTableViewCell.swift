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
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
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
        
        if let reuseID = self.reuseIdentifier {
            switch reuseID {
            case "FirstPrimaryCell":
                maskCellCorners(.TopLeft, secondCorner: .TopRight)
                
            case "LastPrimaryCell":
                maskCellCorners(.BottomLeft, secondCorner: .BottomRight)
                
            default:
                break
            }
        }
    }
    
    // Rounds two corners of a cell
    func maskCellCorners(firstCorner: UIRectCorner, secondCorner: UIRectCorner) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = visualEffectView.frame
        rectShape.position = visualEffectView.center
        rectShape.path = UIBezierPath(roundedRect: visualEffectView.bounds, byRoundingCorners: [firstCorner, secondCorner], cornerRadii: CGSize(width: 9.0, height: 9.0)).CGPath
        
        // Masking the textView's layer with rectShape layer
        visualEffectView.layer.mask = rectShape
    }

}
