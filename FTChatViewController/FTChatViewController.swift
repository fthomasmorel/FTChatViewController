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
    var selectedPath:NSIndexPath?
    
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
        let nib1 = UINib(nibName: "FTMessageCell", bundle: nil)
        tableView.registerNib(nib1, forCellReuseIdentifier: kMessageCell)
        let nib2 = UINib(nibName: "FTImageCell", bundle: nil)
        tableView.registerNib(nib2, forCellReuseIdentifier: kImageCell)
    }
    
    override func viewDidAppear(animated: Bool) {
        let indexPath = NSIndexPath(forRow: messages.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        self.tableView.reloadData()
    }
    
    
    func addMessage(message:FTMessage){
        types.append(self.typeOfMessage(message, withFormerMessage: self.messages.last))
        messages.append(message)
        self.tableView.reloadData()
        let indexPath = NSIndexPath(forRow: messages.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    func addMessages(var messages:[FTMessage]){
        messages.sortInPlace { (prec, next) -> Bool in
            prec.date.isLessThanDate(next.date)
        }
        for i in 1 ... messages.count-1{
            self.messages.append(messages[i])
            self.types.append(self.typeOfMessage(messages[i], withFormerMessage:messages[i-1]))
        }
    }
    
    private func typeOfMessage(message:FTMessage, withFormerMessage formerMessageOpt:FTMessage?) -> FTMessageType{
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
        let message = messages[indexPath.row]
        if let _ = message.content{
           return heightForMessage(messages[indexPath.row], andType: types[indexPath.row]) + (self.selectedPath == indexPath ? 20 : 0)
        }else{
            return 166.0
        }   
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell!
        if let _ = messages[indexPath.row].content{
            if let tmp = tableView.dequeueReusableCellWithIdentifier(kMessageCell) as? FTMessageCell{
                tmp.loadItem(type: types[indexPath.row], withMessage:messages[indexPath.row])
                tmp.onSelection = {
                    self.selectCellAtPath(indexPath)
                }
                cell = tmp
            }else{
                cell = FTMessageCell()
            }
        }else{
            if let tmp = tableView.dequeueReusableCellWithIdentifier(kImageCell) as? FTImageCell{
                cell = tmp
                tmp.loadItem(type: types[indexPath.row], withMessage:messages[indexPath.row])
                tmp.onSelection = {
                    
                }
                cell = tmp
            }else{
                cell = FTImageCell()
            }
        }
        cell.selectionStyle = .None;
        return cell
    }
    
    
    func selectCellAtPath(indexPath:NSIndexPath){
        if(selectedPath == indexPath){
            self.selectedPath = nil
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
        }else{
            self.selectedPath = indexPath
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            if(indexPath.row == messages.count-1){
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            }else{
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
            }
        }
    }
}