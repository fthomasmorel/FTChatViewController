//
//  FTChatViewController.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import UIKit
import Foundation

class FTChatViewController: UITableViewController{
    
    var types:[FTMessageType] = []
    var messages:[FTMessage] = []
    
    func commonInit(){

    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "FTMessageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: kMessageCell)
    }
    
    override func viewDidAppear(animated: Bool) {
        let indexPath = NSIndexPath(forRow: messages.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    func addMessage(message:FTMessage){
        types.append(self.typeOfMessage(message, withFormerMessage: self.messages.last))
        messages.append(message)
        self.tableView.reloadData()
        let indexPath = NSIndexPath(forRow: messages.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func addMessages(messages:[FTMessage]){
        for i in 1 ... messages.count-1{
            self.messages.append(messages[i])
            self.types.append(self.typeOfMessage(messages[i], withFormerMessage:messages[i-1]))
        }
    }
    
    func typeOfMessage(message:FTMessage, withFormerMessage formerMessageOpt:FTMessage?) -> FTMessageType{
        guard let formerMessage = formerMessageOpt else{
            return (message.source == .Local ? .FirstSent : .FirstReceived)
        }
        
        var type:FTMessageType = (message.source == .Local ? .FirstSent : .FirstReceived)
        if message.source == formerMessage.source {
            if message.date.isLessThanDate(formerMessage.date.dateByAddingTimeInterval(NSTimeInterval(kMessageInterval))) {
                type = (message.source == .Local ? .NextSent : .NextReceived)
            }
        }
        return type
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return messages.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForMessage(messages[indexPath.row], andType: types[indexPath.row])
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:FTMessageCell!
        if let tmp = tableView.dequeueReusableCellWithIdentifier(kMessageCell) as? FTMessageCell{
            cell = tmp
        }else{
            cell = FTMessageCell()
        }
        cell.loadItem(type: types[indexPath.row], withMessage:messages[indexPath.row])
        return cell
    }
}