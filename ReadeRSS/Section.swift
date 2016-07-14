//
//  Section.swift
//  ReadeRSS
//
//  Created by Mate Papp on 14/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

class Section: NSObject {
    var date: NSDate
    var articles = [Article]()
    
    var title: String {
        let calendar = NSCalendar.currentCalendar()
        
        if calendar.isDateInToday(date) {
            return "Today"
        }
        
        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }
        else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            return dateFormatter.stringFromDate(date)
        }
    }
    
    init(date: NSDate) {
        self.date = date
    }
  
}