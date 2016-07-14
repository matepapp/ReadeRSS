//
//  Section.swift
//  ReadeRSS
//
//  Created by Mate Papp on 14/07/16.
//  Copyright © 2016 Mate Papp. All rights reserved.
//

import Foundation

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }

class Section: NSObject {
    var date: NSDate
    var items: [Article]
    
    init(date: NSDate, items: [Article]) {
        self.date = date
        self.items = items
    }
    
    func title() -> String {
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let yesterday = calendar.dateByAddingUnit(.Day, value: -1, toDate: NSDate(), options: [])
        
        if date == today {
            return "Today"
        }
        else if date == yesterday {
            return "Yesterday"
        }
        else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "EEEE, MMMM d"
            return dateFormatter.stringFromDate(date)
        }
    }
    

}