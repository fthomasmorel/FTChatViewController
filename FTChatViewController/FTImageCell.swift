//
//  FTImageCell.swift
//  FTChatViewController
//
//  Created by Florent TM on 31/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit

let kImageCell = "imageCell"

//let sentColor = UIColor(red: 29/255, green: 121/255, blue: 243/255, alpha: 1)
//let receivedColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)

class FTImageCell : UITableViewCell{
    
    var type:FTMessageType?
    var onSelection:(() -> Void)?
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    
    override func layoutSubviews(){
        let tap = UITapGestureRecognizer(target: self, action: "tapOnImage:")
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        messageImageView.addGestureRecognizer(tap)
        
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
    }
    
    func loadItem(type type:FTMessageType, withMessage message:FTMessage) {
        self.messageImageView.image = message.image!
        self.messageImageView?.layer.cornerRadius = kCorderRadius/2
        self.messageImageView?.layer.masksToBounds = true
        self.type = type
    }

    
    func setCellAsFirstReceived(){
        self.containerView.layer.cornerRadius = kCorderRadius
        self.containerView.backgroundColor = receivedColor
        self.topConstraint.constant = kMarginTopFirst
        self.leftConstraint.constant = kMarginLeft
        self.rightConstraint.active = false
        self.leftConstraint.active = true
    }
    
    func setCellAsFirstSent(){
        self.containerView.layer.cornerRadius = kCorderRadius
        self.containerView.backgroundColor = sentColor
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

    
    func tapOnImage(sender: AnyObject) {
        if let _ = onSelection {
            self.onSelection!()
        }
    }
}

