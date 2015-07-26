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
    var contents:[String] = []
    
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
        
        
        //initTab
        for i in 0 ... 50{
            var type:FTMessageType!
            var content:String!
            switch(i % 4){
            case 0:
                type = .FirstReceived
                content = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna"
                break;
            case 1:
                type = .NextReceived
                content = "Hello"
                break;
            case 2:
                type = .FirstSent
                content = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna"
                break;
            default:
                type = .NextSent
                content = "ok"
                break;
            }
            contents.append(content)
            types.append(type)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        let indexPath = NSIndexPath(forRow: contents.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    
    
    func addMessage(content content:String, type:FTMessageType){
        contents.append(content)
        types.append(type)
        self.tableView.reloadData()
        let indexPath = NSIndexPath(forRow: contents.count-1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return contents.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightForContent(contents[indexPath.row], andType: types[indexPath.row])
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:FTMessageCell!
        if let tmp = tableView.dequeueReusableCellWithIdentifier(kMessageCell) as? FTMessageCell{
            cell = tmp
        }else{
            cell = FTMessageCell()
        }
        cell.loadItem(type: types[indexPath.row], withContent:contents[indexPath.row])
        return cell
    }
}