//
//  FTHelpers.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit


let kMarginLeft:CGFloat = 10
let kMarginRight:CGFloat = 10
let kMarginTopFirst:CGFloat = 15
let kMarginTopNext:CGFloat = 2
let kMaxWidth:CGFloat = 240
let kCorderRadius:CGFloat = 10

let kFontSize = 15
let kMessageInterval = 60


extension UITextView {
    func sizeForMaxWidth(maxWidth:CGFloat) -> CGSize{
        let fixedWidth = maxWidth
        self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        return CGSize(width: min(newSize.width, fixedWidth), height: newSize.height)
    }
}


//From stackoverflow : http://stackoverflow.com/questions/26198526/nsdate-comparison-using-swift
extension NSDate
{
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool{
        return self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
    }
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool{
        return self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
    }
 
    func addDays(daysToAdd : Int) -> NSDate{
        let secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd : Int) -> NSDate{
        let secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
}


func heightForMessage(message:FTMessage, andType type:FTMessageType) -> CGFloat{
    let textView = UITextView()
    textView.text = message.content
    textView.font = UIFont(name: "Helvetica", size: CGFloat(kFontSize))
    var height = textView.sizeForMaxWidth(kMaxWidth).height
    switch(type){
    case .FirstReceived, .FirstSent:
        height += kMarginTopFirst
        break;
    case .NextReceived, .NextSent:
        height += kMarginTopNext
        break;
    }
    return height
}
