//
//  FTViewController.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation

import UIKit
import Foundation

class FTViewController: UIViewController{
    @IBOutlet weak var container: UIView!
    
    override func viewDidLoad() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let chatVC = storyboard.instantiateViewControllerWithIdentifier("ChatViewController") as? FTChatViewController {
            chatVC.view.frame = CGRectMake(0, 0, chatVC.view.frame.width, chatVC.view.frame.height-80)
            self.view.addSubview(chatVC.view)
            self.addChildViewController(chatVC)
        }
    }

    @IBAction func send(sender: AnyObject) {
        (self.childViewControllers[0] as! FTChatViewController).addMessage(content: "Kikou", type: .NextSent)
    }
}