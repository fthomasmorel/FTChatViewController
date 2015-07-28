//
//  FTMessageCell.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit

let kMessageCell = "messageCell"

enum FTMessageType{
    case FirstReceived
    case FirstSent
    case NextReceived
    case NextSent
}

let sentColor = UIColor(red: 29/255, green: 121/255, blue: 243/255, alpha: 1)
let receivedColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

class FTMessageCell : UITableViewCell, UITextViewDelegate{
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var type:FTMessageType?
    var onSelection:(() -> Void)?
    
    override func layoutSubviews(){
        let tap = UITapGestureRecognizer(target: self, action: "test:")
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        containerView.addGestureRecognizer(tap)
        
        switch(self.type!){
        case .FirstReceived:
            self.setCellAsFirstReceived()
            break
        case .FirstSent:
            self.setCellAsFirstSent()
            break
        case .NextReceived:
            self.setCellAsNextReceived()
            break
        case .NextSent:
            self.setCellAsNextSent()
            break
        }
        self.setMessageViewHeightForTextField(self.messageView)
    }
    
    func loadItem(type type:FTMessageType, withMessage message:FTMessage) {
        self.type = type
        self.messageView.text = message.content
        self.messageView.delegate = self
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM hh:mm"
        self.detailsLabel.text = "\(dayForIndex(message.date.getDay())). \(dateFormatter.stringFromDate(message.date))"
        self.detailsLabel.textAlignment = (message.source == .Local ? .Right : .Left)
    }
    
    
    func setCellAsFirstReceived(){
        self.messageView.layer.cornerRadius = kCorderRadius
        self.messageView.backgroundColor = receivedColor
        self.messageView.textColor = .blackColor()
        self.topConstraint.constant = kMarginTopFirst
        self.leftConstraint.constant = kMarginLeft
        self.rightConstraint.active = false
        self.leftConstraint.active = true
    }
    
    func setCellAsFirstSent(){
        self.messageView.layer.cornerRadius = kCorderRadius
        self.messageView.backgroundColor = sentColor
        self.messageView.textColor = .whiteColor()
        self.topConstraint.constant = kMarginTopFirst
        self.rightConstraint.constant = kMarginRight
        self.leftConstraint.active = false
        self.rightConstraint.active = true
    }
    
    func setCellAsNextReceived(){
        self.setCellAsFirstReceived()
        self.topConstraint.constant = kMarginTopNext
    }
    
    func setCellAsNextSent(){
        self.setCellAsFirstSent()
        self.topConstraint.constant = kMarginTopNext
    }
    
    func setMessageViewHeightForTextField(textView:UITextView){
        let size = self.messageView.sizeForMaxWidth(kMaxWidth)
        self.heightConstraint.constant = size.height
        self.widthConstraint.constant = size.width
        self.messageView.updateConstraints()
    }
    
    @IBAction func test(sender: AnyObject) {
        if let _ = onSelection {
            self.onSelection!()
        }
    }
}