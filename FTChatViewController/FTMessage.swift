//
//  FTMessage.swift
//  FTChatViewController
//
//  Created by Florent TM on 26/07/2015.
//  Copyright © 2015 Florent THOMAS-MOREL. All rights reserved.
//

import Foundation
import UIKit

enum FTMessageSource{
    case Local
    case Remote
}

class FTMessage:AnyObject{
 
    var content:String?
    var image:UIImage?
    var date:NSDate
    var source:FTMessageSource
    
    init(messageWithContent content:String, atDate date:NSDate, from source:FTMessageSource){
        self.content = content
        self.date = date
        self.source = source
    }

    init(messageWithImage image:UIImage, atDate date:NSDate, from source:FTMessageSource){
        self.image = image
        self.date = date
        self.source = source
    }

}